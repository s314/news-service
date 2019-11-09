using MySQL
using DataFrames

using TextAnalysis
include("bayes.jl")

# Устанавливаем байесовский классификатор на новостные категории
m = NaiveBayesClassifier([:technology, :business, :politics, :sport, :culture, :criminal])


# Функция для определения классов
function predict_classes(pstring)
	res = predict(m, pstring)
	return res
end


# Процедура для переобучения классификатора
function re_learn()
    categories = [:technology, :business, :politics, :sport, :culture, :criminal]
	global m = NaiveBayesClassifier(categories)

	"""
	Конфигурация БД
	"""
	conn = MySQL.connect(
		"localhost",
		"root",
		"",
		db = "serviceNewsFeed_development",
		unix_socket = "/var/run/mysqld/mysqld.sock",
		opts=Dict(MySQL.API.MYSQL_SET_CHARSET_NAME=>"utf8")
		)

	"""
	Получаем корпус текстов для всех категорий
	"""
	for category in categories
	@show category
		dc_query = MySQL.Query(conn, """SELECT * FROM learning_entries WHERE category = '$(string(category))';""") |> DataFrame
		for r in eachrow(dc_query)
			a = r.title * ' ' * r.description

			fit!(m, a, category)
		end
	end

	"""
	Отключаемся от БД
	"""
	MySQL.disconnect(conn)
	println("Learning successfully ended!")
end

# Первоначальное обучение классификатора при запуске
re_learn()