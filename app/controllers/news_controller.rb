require "net/http"
require "json"

class NewsController < ApplicationController

  def index
    @news = rss_parse params[:category]
  end

  def stats
    news = rss_parse
    @counts = Hash.new
    news.each do |entry|
      if @counts[entry["class"]].present?
        @counts[entry["class"]] += 1
      else
        @counts[entry["class"]] = 1
      end
    end

    @data = @counts.map { |key, value| [key.to_s.capitalize, value] }

  end

  private

  def rss_parse (category = "all")
    require 'rss'
    require 'open-uri'

    rss_feeds = %w(
        https://meduza.io/rss/all
        https://lenta.ru/rss/news
        https://www.vesti.ru/vesti.rss
        https://www.popmech.ru/out/public-all.xml
    )

    rss_results = []

    rss_feeds.each do |feed|
      rss = RSS::Parser.parse(open(feed).read, false).items
      # rss = RSS::Parser.parse(open('http://feeds.feedburner.com/CoinDesk?format=xml').read, false).items[0..5]

      rss.each do |result|
        result = { title: result.title, date: result.pubDate, link: result.link, description: result.description, enclosure: result.enclosure.url }
        rss_results.push(result)
      end
    end

    http = Net::HTTP.new("127.0.0.1", "8080")

    request = Net::HTTP::Post.new("http://127.0.0.1:8080/resource/process", 'Content-Type' => 'application/json')
    request.body = { dict: rss_results }.to_json

    response = http.request(request)

    rss_analyzed = JSON.parse(response.body)

    return rss_analyzed["dict"] if category == "all" || category.nil?

    rss_analyzed["dict"].select { |hash| hash["class"] == category }

  end

end