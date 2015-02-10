# coding: utf-8
namespace :expertfisher do
	task :import => :environment do
		ProcessCategory("http://expertfisher.ru/CatalogCategoryRl.aspx")
#		ProcessCategory("http://expertfisher.ru/category-r/13-0-0-primanki.aspx")

	end

	def ProcessCategory(url)
		cat = Nokogiri::HTML(open(url))
		curr_ext_id=url[/\/([^\/]+?)\.aspx/,1]

		cat.xpath('//div[@class="rounded-white"]/div[@class="body"]/a').each do |subcat|
			sub_url=subcat.attr('href')
			ext_id=sub_url[/\/([^\/]+?)\.aspx/,1]
			
			category=Category.find_or_create_by(external_id: ext_id)
			category.parent=Category.find_by(external_id: curr_ext_id) if curr_ext_id
			category.external_id=ext_id
			category.name=subcat.xpath('h4').first.content
			puts category.name
			category.enabled=true
			category.save!

			ProcessCategory(sub_url)
		end

		cat.xpath('//td[@class="item"]/div/a/@href').each do |prod_link|
			prod = Nokogiri::HTML(open(prod_link))
			sku = 'expertfisher_'+prod_link.content[/\/([^\/]+?)\.aspx/, 1]
			product=Product.find_or_create_by(sku: sku)

			product.name=prod.xpath('//div[@class="block description clearfix"]/h1').first.content
			puts product.name
			product.categories.clear
			product.categories << Category.find_by(external_id: curr_ext_id)
			product.sku=sku
			if descr=prod.xpath('//div[@class="block description clearfix"]').first
				descr.xpath('h1').remove
				img_str=descr.xpath('div[@id="ctl00_ctl00_cph1_cphLeft_ctrlProductDescription_teaserPanel"]').first.content
				descr.xpath('div[@id="ctl00_ctl00_cph1_cphLeft_ctrlProductDescription_teaserPanel"]').remove
				descr.css('img').each do |img|
					url=img.attr('src')
					unless image=DescriptionImage.find_by(original_url: url)
						image=DescriptionImage.new
						url = "http://expertfisher.ru#{url}" unless url.start_with?('http://expertfisher.ru')
						image.remote_image_url=url
						image.save
					end
					img.attributes['src'].value=image.image.url					
				end
				product.description=descr.to_s 
			end
			product.enabled=true

			attr_names=[]
			prod.xpath('id("ctl00_ctl00_cph1_cphLeft_ProductVariantList_pnlMain")/div[3]/table/tr').first.xpath('th')[3..-4].each do  |attr_name|
				attr_names<<attr_name.content
			end

			prod.xpath('id("ctl00_ctl00_cph1_cphLeft_ProductVariantList_pnlMain")/div/table/tr')[1..-1].each do |var|
				if var.xpath('td').first
					variant_sku=var.xpath('td[3]/b').first.content
					variant=product.variants.find_or_create_by(sku: variant_sku)
					variant.sku=variant_sku
					variant.price=var.xpath('td[last()-2]/b').first.content.delete(' ').gsub(/[[:space:]]/,'')
					variant.enabled = (var.xpath('td[last()-2]/p/span/span').first && var.xpath('td[last()-2]/p/span/span').first.content == 'В наличии')
					
					i=0
					var.xpath('td')[3..-4].each do |attrib|
						variant.attr[attr_names[i]]=attrib.content
						i+=1
					end

					if !variant.image?
						if img=var.xpath('td[2]//img').first
							pic_url=img.attr('src')
							variant.remote_image_url=pic_url
						end
					end
					
					variant.name=nil
					variant.save!
				end
			end				
			product.save!

			if product.images.count == 0
				img_str.scan(/push\('(.+?)'/).each do |pic|
					pic_url=pic[0]
					begin
						image=product.images.new
						image.remote_image_url=pic_url
						image.save
					rescue
						image.delete
					end
				end
			end
		end
	end
end