ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'rack/test'
require_relative 'number_cruncher'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Number Cruncher' do
  it "should return the factors of 6" do
    expect(6.factors).to eq [1,2,3,6]
  end

  it "should say that 2 is prime" do
    expect(2.prime?).to be_true
  end
  
  it "should say that 10 is not prime" do
    expect(10.prime?).to be_false
  end

  it "should return json" do
    get '/6'
    expect(last_response.headers['Content-Type']).to eq 'application/json;charset=utf-8'
  end

  it "should return the correct info about 6 as json" do
    get '/6'
    six_info = { number: 6, factors: 6.factors, odd: 6.odd?, even: 6.even?, prime: 6.prime? }
    expect(six_info.to_json).to eq last_response.body
  end
end
