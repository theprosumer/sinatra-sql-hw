require 'sinatra'
require	'json'
require	'pg'

conn = PGconn.open(:dbname => 'practice')				#conn is the variable the holds the connection to the db

get '/' do
	res = conn.exec('SELECT * FROM restaurants;')		#notice this is the Postgres syntax
	restaurants = []									#set var restaurants
	res.each do |restaurant|
		restaurants.push(restaurant)
	end
	restaurants.to_json
end	


##RESPONSE
get '/restaurants/:id' do									#get resturant by id
	id = params[:id]										#same value as in route
	res = conn.exec("SELECT id, name, health FROM restaurants WHERE id = #{id};")
	res[0].to_json
end

###CREATE
post'/restaurants' do
	data = eval(request.body.read)
	name = data[:name]
	cuisine = data[:cuisine]
	price = data[:price]
	health = data[:health]

	conn.exec("INSERT INTO restaurants (name, cuisine, price, health) VALUES
	('#{name}', '#{cuisine}', #{price}, '#{health}')")
	"Success"

end	
