using LibPQ
using Tables
using DataFrames

using TextAnalysis
include("bayes.jl")

# Устанавливаем байесовский классификатор на новостные категории
m = NaiveBayesClassifier([:technology, :business, :politics, :sport, :culture, :criminal])



"""
    predict_classes(pstring)

Функция для определения классов
"""
function predict_classes(pstring)
	res = predict(m, pstring)
	return res
end



"""
    re_learn()

Процедура для переобучения классификатора
"""
function re_learn()
    categories = [:technology, :business, :politics, :sport, :culture, :criminal]
	global m = NaiveBayesClassifier(categories)

	"""
	Конфигурация БД
	"""
	conn = LibPQ.Connection("dbname=serviceNewsFeed_development user=s314 password=qwerty host=localhost")

	"""
	Получаем корпус текстов для всех категорий
	"""
	for category in categories
	@show category
		dc_query = execute(conn, """SELECT * FROM learning_entries WHERE category = '$(string(category))';""") |> DataFrame
		for r in eachrow(dc_query)
			a = r.title * ' ' * r.description

			fit!(m, a, category)
		end
	end

	"""
	Отключаемся от БД
	"""
	close(conn)
	@show ("Learning successfully ended!")
end

re_learn() # Первоначальное обучение классификатора при запуске