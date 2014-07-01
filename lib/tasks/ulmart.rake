# coding: utf-8
namespace :ulmart do
	task :update => :environment do
		urls = {"http://www.ulmart.ru/catalog/mirror_camera_5818_24945"=>'2'}
		urls.each_key do |url|
			page=1
			while true
				cat = Nokogiri::HTML(open("#{url}?page=#{page}"))
				cat.xpath('//div[@class="b-product-list-item__title"]/a').each do |prod_item|
					name=prod_item.content.strip
#					next if not (name.index('DOD') or name.index('КАРКАМ') or name.index('Sho-Me')or name.index('Crunch')or name.index('Whistler')or name.index('Garmin')or name.index('Navitel')or name.index('парктроник')or name.index('Sheriff')or name.index('StarLine')or urls[url]==5)
#					name.gsub!('антирадар', 'Радар-детектор')
					puts "#{name}"
					prod_url=prod_item['href']
					prod = Nokogiri::HTML(open("http://www.ulmart.ru#{prod_url}"))
					sku=prod.xpath('//span[@class="b-art"]/span').first.content
					descr=prod.xpath('//section[@id="properties_full"]').to_html
					price=prod.xpath('//div[@class="b-product-card__price"]/span/span[1]').first.content;
					price.gsub!(/[[:space:]]/, '')

					product=Product.find_or_create_by(sku: sku)
					product.name=name
					product.sku=sku
					product.description=descr
					if price.to_i>1000
						product.price=price.to_i+200
					else
						product.price=price.to_i
					end
					product.enabled=true
					product.categories << Category.find(urls[url])
					product.count=0 if !product.count or product.count==0

					# Manufacturer.all.each do |man|
					# 	if name.include?(man.name)
					# 		product.manufacturer=man
					# 	end
					# end

					product.save
#					if product.new_record?
						product.images.clear
						image=product.images.new
						image.remote_image_url="http://fast.ulmart.ru/good_pics/#{sku}.jpg"
						image.save!
#					end
				end
				break if cat.xpath('//div[@id="hide-show-more-lnk"]').first.content.to_i<=0
				page=page+1
			end
		end
	#	Product.where('updated_at < ?', 20.minutes.ago).update_all(hidden:true)
	end
end