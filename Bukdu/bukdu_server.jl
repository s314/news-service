using Bukdu
using JSON
include("db_learning.jl")

struct WelcomeController <: ApplicationController
    conn::Conn
end

function process_resource(c::WelcomeController)
    json = JSON.parse(String(c.conn.request.body))
    
    # Посмотрим в цикле все новости в формате RSS
    for dict in json["dict"]
	classes = predict_classes(dict["title"] * " " * dict["description"])
	@show dict["title"], " ", classes
	# Найдем категорию с наибольшим значением
	prior_class = findmax(classes)
	# Впишем категорию в новость
	dict["class"] = last(prior_class)
    end

    @show json

    render(JSON, json)
end

routes() do
    post("/resource/process", WelcomeController, process_resource)
end

Bukdu.start(8080)

Base.JLOptions().isinteractive == 0 && wait()
