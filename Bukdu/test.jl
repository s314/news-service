using TextAnalysis
include("bayes.jl")

m = NaiveBayesClassifier([:technology, :business, :politics, :sport])

"""
Получаем корпус текстов для категории "Технологии"
"""
dc_technology = DirectoryCorpus("corpus/technology")

for i in dc_technology.documents
    fit!(m, text(i), :technology)
end

"""
Получаем корпус текстов для категории "Бизнес"
"""
dc_business = DirectoryCorpus("corpus/business")

for i in dc_business.documents
    fit!(m, text(i), :business)
end

"""
Получаем корпус текстов для категории "Политика"
"""
dc_politics = DirectoryCorpus("corpus/politics")

for i in dc_politics.documents
    fit!(m, text(i), :politics)
end

"""
Получаем корпус текстов для категории "Спорт"
"""
dc_sport = DirectoryCorpus("corpus/sport")

for i in dc_sport.documents
    fit!(m, text(i), :sport)
end


"""
Рассчитать вероятности попадания в категорию
"""
function predict_classes(pstring)
	res = predict(m, pstring)
	return res
end


conn = LibPQ.Connection("dbname=postgres user=s314 password=qwerty host=localhost")