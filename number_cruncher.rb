require 'sinatra'
require 'json'

class Integer
  def factors
    root = self**0.5
    (1..root).map { |n| [n,self/n] if self/n*n == self }.compact.flatten.sort
  end

  def prime?
    factors.size == 2
  end
end

get "/:number" do
  content_type :json
  number = params[:number].to_i
  { number: number,
    factors: number.factors,
    odd: number.odd?,
    even: number.even?,
    prime: number.prime? }.to_json
end

