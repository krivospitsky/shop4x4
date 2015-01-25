# coding: utf-8
namespace :yml do
	task :import => :environment do

		supplier='nova'
		skip_cats=[246] if supplier == 'camp'
		skip_cats=[300] if supplier == 'nova'

		start_time=Time.now
		loaded_images=[]

		if Rails.env == 'production'
			url='http://krivospitsky.ru/nova.yml' if supplier == 'nova'
			yml = Nokogiri::XML(open(url))
		else
			yml = Nokogiri::XML(open("tmp/yml/#{supplier}.yml"))
		end

		yml.xpath('//categories/category').each do |node|
			parent_id=node.attr('parentId')
			id=node.attr('id')

			skip_cats << id if skip_cats.include?(parent_id)
			next if skip_cats.include?(id);

			category=Category.find_or_create_by(external_id: "#{supplier}_#{id}")
			category.parent=Category.find_by(external_id: "#{supplier}_#{parent_id}") if parent_id
			category.external_id="#{supplier}_#{id}"
			category.name=node.content.strip
			category.enabled=true
			category.save!
		end

		yml.xpath('//offers/offer').each do |node|
			cat_id=node.xpath('categoryId').first.content
			next if skip_cats.include?(cat_id)

			id=node.attr('id')
			
			vendorCode=node.xpath('vendorCode').first.content if node.xpath('vendorCode').first
#			vendorCode|=node.articul.content if node.articul

			manufacturer=node.xpath('vendor').first.content

			sku="#{supplier}_#{id}"
			sku="nova_#{manufacturer}.#{vendorCode}" if supplier == 'nova'

			product=Product.find_or_create_by(sku: sku)
			if (supplier == 'camp')
				product.name=node.xpath('typePrefix').first.content
			elsif supplier == 'salmo'
				product.name=node.xpath('name').first.content				
			else
				product.name=node.xpath('model').first.content
			end
			puts product.name
			product.categories.clear
			product.categories << Category.find_by(external_id: "#{supplier}_#{cat_id}")
			product.sku=sku

			product.attr=nil
			node.xpath("param").each do |param|
				if param['name'] != 'Цвет' && param['name'] != 'Размер' 
					if param.content == 'true'
						product.attr[param['name']]='Да'
					elsif param.content == 'false'
						product.attr[param['name']]='Нет'
					elsif param.content!=''
						product.attr[param['name']]=param.content
					end
				end
			end

			color=node.xpath("param[@name='Цвет']").first.content if node.xpath("param[@name='Цвет']").first
			size=node.xpath("param[@name='Размер']").first.content if node.xpath("param[@name='Размер']").first

			puts color
			puts size

			variant_sku=node.xpath('barcode').first.content if node.xpath('barcode').first
			if not variant_sku
				variant_sku=sku
				variant_sku+=".#{color}" if color
				variant_sku+=".#{size}" if size
			end
			variant_name=product.name
			variant_name+=" цвет #{color}" if color
			variant_name+=" размер #{size}" if size
			

			variant=product.variants.find_or_create_by(sku: variant_sku)
			variant.sku=variant_sku
			variant.name=variant_name
			variant.price=node.xpath('price').first.content
			variant.enabled=true
			variant.save!

			product.description=node.xpath('description').first.content if node.xpath('description').first
			product.enabled=true

			product.save!

			if product.new_record?
				product.images.where("created_at < :start_time", {start_time: start_time}).delete_all
				node.xpath('picture').each do |pic|
					pic_url=pic.content
					if not loaded_images.include?(pic_url)
						begin
							puts pic_url
							loaded_images << pic_url

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
# #	my $price=$offer->findvalue('price');
# 	my $price=($offer->findnodes('price'))[0]->toString;
# 	$price=~s/\<price\>(.*)\<\/price\>/$1/;
# 	$price=~s/,//;

	
# 	while ($name=~s/"/&quot;/g){};


# 	my $length=$offer->findvalue('extprops/length'); #для рыболов-сервис импортируем длину
# 	my $width=$offer->findvalue('extprops/width'); #для рыболов-сервис импортируем ширину
# 	my $height=$offer->findvalue('extprops/height'); #для рыболов-сервис импортируем высоту
# #       my $weight=$offer->findvalue('extprops/weight'); #для рыболов-сервис импортируем вес
# 	my $points=$price-1;
# 	my $points2=ceil($price*0.02);


# 		end


# 				cat.xpath('//div[@class="b-product-list-item__title"]/a').each do |prod_item|
# 					name=prod_item.content.strip
# #					next if not (name.index('DOD') or name.index('КАРКАМ') or name.index('Sho-Me')or name.index('Crunch')or name.index('Whistler')or name.index('Garmin')or name.index('Navitel')or name.index('парктроник')or name.index('Sheriff')or name.index('StarLine')or urls[url]==5)
# #					name.gsub!('антирадар', 'Радар-детектор')
# 					puts "#{name}"
# 					prod_url=prod_item['href']
# 					prod = Nokogiri::HTML(open("http://www.ulmart.ru#{prod_url}"))
# 					sku=prod.xpath('//span[@class="b-art"]/span').first.content
# 					descr=prod.xpath('//section[@id="properties_full"]').to_html
# 					price=prod.xpath('//div[@class="b-product-card__price"]/span/span[1]').first.content;
# 					price.gsub!(/[[:space:]]/, '')

# 					product=Product.find_or_create_by(name: name)
# 					product.name=name
# 					product.description=descr
# 					product.categories << Category.find(urls[url])

# 					# Manufacturer.all.each do |man|
# 					# 	if name.include?(man.name)
# 					# 		product.manufacturer=man
# 					# 	end
# 					# end

# 					product.save
# #					if product.new_record?
# 						product.images.clear
# 						image=product.images.new
# 						image.remote_image_url="http://fast.ulmart.ru/good_pics/#{sku}.jpg"
# 						image.save!
# #					end
# 				end
# 				break if cat.xpath('//div[@id="hide-show-more-lnk"]').first.content.to_i<=0
# 				page=page+1
# 			end
# 		end
# 	#	Product.where('updated_at < ?', 20.minutes.ago).update_all(hidden:true)
	end
end