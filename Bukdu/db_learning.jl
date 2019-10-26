using MySQL
using DataFrames

using TextAnalysis
include("bayes.jl")

m = NaiveBayesClassifier([:technology, :business, :politics, :sport, :culture, :criminal])


"""
Конфигурация БД
"""
conn = MySQL.connect("localhost", "root", "", db = "serviceNewsFeed_development", unix_socket = "/var/run/mysqld/mysqld.sock", opts=Dict(MySQL.API.MYSQL_SET_CHARSET_NAME=>"utf8"))
println("Connected to DB successfully...")


"""
Получаем корпус текстов для категории "Технологии"
"""
dc_technology = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = 'technology';""") |> DataFrame

for r in eachrow(dc_technology)
    a = r.title * ' ' * r.description
    fit!(m, a, :technology)
end


"""
Получаем корпус текстов для категории "Бизнес"
"""
dc_business = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = 'business';""") |> DataFrame

for r in eachrow(dc_business)
    a = r.title * ' ' * r.description
    fit!(m, a, :business)
end


"""
Получаем корпус текстов для категории "Политика"
"""
dc_politics = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = 'politics';""") |> DataFrame

for r in eachrow(dc_politics)
    a = r.title * ' ' * r.description
    fit!(m, a, :politics)
end


"""
Получаем корпус текстов для категории "Спорт"
"""
dc_sport = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = 'sport';""") |> DataFrame

for r in eachrow(dc_sport)
    a = r.title * ' ' * r.description
    fit!(m, a, :sport)
end


"""
Отключаемся от БД
"""
MySQL.disconnect(conn)



function predict_classes(pstring)
	res = predict(m, pstring)
	return res
end


function re_learn()
    categories = [:technology, :business, :politics, :sport, :culture, :criminal]
	global m = NaiveBayesClassifier(categories)

	"""
	Конфигурация БД
	"""
	conn = MySQL.connect("localhost", "root", "", db = "serviceNewsFeed_development", unix_socket = "/var/run/mysqld/mysqld.sock", opts=Dict(MySQL.API.MYSQL_SET_CHARSET_NAME=>"utf8"))

	"""
	Получаем корпус текстов для всех категорий
	"""
	for category in categories
	@show category
		dc_query = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = '$(string(category))';""") |> DataFrame
		for r in eachrow(dc_query)
			a = r.title * ' ' * r.description
			@show a
			fit!(m, a, category)
		end
	end

	"""
	Отключаемся от БД
	"""
	MySQL.disconnect(conn)
	println("Learning successfully ended!")
end