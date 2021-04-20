json.extract! product, :id, :name, :family, :productcode, :created_at, :updated_at
json.url product_url(product, format: :json)
