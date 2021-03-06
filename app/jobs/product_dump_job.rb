class ProductDumpJob < ApplicationJob
  queue_as :default
  require 'rest-client'
  require 'json'
  require 'ostruct'

  attr_accessor :price
  attr_accessor :name

  @@api_key = 'Bearer sq0atp-HMKVjMfhw-nluwIJj2C1dQ'

  def perform(*args)
        begin
            items = RestClient.get 'https://connect.squareup.com/v1/BSKDMCM5AWEB3/items', {:Authorization => @@api_key}

            json_items = JSON.parse(items, object_class: OpenStruct)
            json_items.each do |ji|
                filtered_item = Product.new
                filtered_item.name = ji.name
                filtered_item.active = true

                ji.variations.each do |ji2|
                    filtered_item.price = 5.00
                end

                filtered_item.save
            end
        rescue => exception

        end
  end
end

ProductDumpJob.perform_now
