require 'sinatra'
require	'json'
require	'pg'

conn = PGconn.open(:dbname => 'practice')				#conn is the variable the holds the connection to the db

##response to render all restaurants in the table as a json object
get '/' do
	res = conn.exec('SELECT * FROM restaurants;')		#notice this is the Postgres syntax
	restaurants = []									#set var restaurants
	res.each do |restaurant|
		restaurants.push(restaurant)
	end
	restaurants.to_json
end	


##RESPONSE
##General response to return a  specific restaurant by id parameter
get '/restaurants/:id' do									#get resturant by id
	id = params[:id]										#same value as in route
	res = conn.exec("SELECT id, name, health FROM restaurants WHERE id = #{id};")
	res[0].to_json
end

###CREATE/INSERT
##Evaluate data for match to model and Insert a new record that matches db model
post '/restaurants' do
	 data = eval(request.body.read)
	 name = data[:name]
	 cuisine = data[:cuisine]
	 price = data[:price]
	 health = data[:health]

	 conn.exec("INSERT INTO restaurants (name, cuisine, price, health) VALUES
	 ('#{name}', '#{cuisine}', #{price}, '#{health}';)")
	 "Success"

end	

###PATCH/UPDATE
###Grab a table item by parameter of id and update it
post '/restaurants/:id' do
	data = eval(request.body.read)
	name = data[:name]
	cuisine = data[:cuisine]
	price = data[:price]
	health = data[:health]

	conn.exec("UPDATE restaurants SET (name = '#{name}, cuisine = '#{cuisine}', 
	price = '#{price}', health = '#{health}' WHERE id = #{id};)")
	"Success"
end	


###DELETE
###Grab restaurant by parameter of id and delete it
delete '/restaurants/:id' do
	id = params[:id]
	conn.exec("DELETE FROM restaurants WHERE id = #{id};")
	"Success"
end

#################
##Route to get all entree items
get '/entrees/' do
	res = conn.exec('SELECT * FROM entrees;')
	restaurants = []
	res.each do |entrees|
		entrees.push(entree)
	end
	entrees.to_json	
end

##Route to get a single entree item
get '/entrees/:id' do
	id = params[:id]
	res = conn.exec("SELECT id, protein FROM entrees WHERE id = #{id};")
	res[0].to_json
end	

##route to update an existing entree item
post '/entrees/:id' do
	data = eval(request.body.read)
	protein = data[:protein]
	veggie = data[:veggie]
	carb = data[:carb]

	conn.exec("UPDATE entrees SET protein = #{'protein'}, veggie = #{'veggie'}, 
	carb=#{'carb'} WHERE id = #{id};")
end

##route to insert a new entree 
post '/entrees' do
	data = eval(request.body.read)
	protein = data[:protein]
	veggie = data[:veggie]
	carb = data[:carb]
	conn.exec("INSERT INTO entrees(protein, veggie, carb) 
	VALUES('#{protein}', '#{veggie}', '#{'carb'};)")
end

##route to delete an entree
delete '/entrees/:id' do
	id = params[:id]
	conn.exec("DELETE FROM entrees WHERE id = #{id};")
	"Success"
end	


