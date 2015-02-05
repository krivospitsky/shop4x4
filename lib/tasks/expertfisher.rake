# coding: utf-8
namespace :expertfisher do
	task :import => :environment do
		ProcessCategory("http://expertfisher.ru/CatalogCategoryRl.aspx")
	end

	def ProcessCategory(url)
		cat = Nokogiri::HTML(open(url))
		curr_ext_id=url[/\/([^\/]+?)\.aspx/,1]

		cat.xpath('//div[@class="rounded-white"]/div[@class="body"]/a').each do |subcat|
			sub_url=subcat.attr('href')
			name=subcat.xpath('h4').first.content
			ext_id=sub_url[/\/([^\/]+?)\.aspx/,1]
			
			category=Category.find_or_create_by(external_id: ext_id)
			category.parent=Category.find_by(external_id: curr_ext_id) if curr_ext_id
			category.external_id=ext_id
			category.name=name
			category.enabled=true
			category.save!

			ProcessCategory(sub_url)
		end

		cat.xpath('//td[@class="item"]/div/a/@href').each do |prod_link|
			prod = Nokogiri::HTML(open(prod_link))
			puts prod_link.content
			sku = prod_link.content[/\/([^\/]+?)\.aspx/, 1]
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
				product.description=descr.to_s 
			end
			product.enabled=true

			prod.xpath('id("ctl00_ctl00_cph1_cphLeft_ProductVariantList_pnlMain")/div[3]/table/tr')[1..-1].each do  |var|
				variant_sku=var.xpath('td[3]/b').first.content
				variant=product.variants.find_or_create_by(sku: variant_sku)
				variant.sku=variant_sku
				variant.price=var.xpath('td[last()-2]/b').first.content.delete(' ').gsub(/[[:space:]]/,'')
				variant.enabled = (var.xpath('td[last()-2]/p/span/span').first.content == 'В наличии')
				
				variant.name="#{product.name} - #{variant_sku}"
				variant.save!
			end				
			product.save!

			# if product.new_record?
#				product.images.where("created_at < :start_time", {start_time: start_time}).delete_all
				product.images.delete_all
				img_str.scan(/push\('(.+?)'/).each do |pic|
					pic_url=pic[0]
					begin
						puts pic_url
						image=product.images.new
						image.remote_image_url=pic_url
						image.save
					rescue
						image.delete
					end
				end
			# end

		end
	end
end