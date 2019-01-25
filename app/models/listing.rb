class Listing < ApplicationRecord
	belongs_to :user
	paginates_per 10

	scope :listing_name, -> (listing_name) { where("name ILIKE ?" , "%#{listing_name}%")   }
    scope :descrip, -> (description) { where("description ILIKE ?", "%#{description}%" ) }
	scope :price, -> (min_price, max_price) { where("price BETWEEN ? and ?", min_price, max_price ) }
	
	def self.search_city(query)
		where("name ILIKE :name", name: "%#{query}%").map do |record|
		  record.name 
		end
	end
end
