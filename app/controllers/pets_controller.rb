class PetsController < ApplicationController

  get '/pets/' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets' do 
    
    if !params["owner_name"].empty?
      @owner = Owner.create(name: params["owner_name"])
    else
      @owner = Owner.find(params["owner_id"])
    end
    @pet = Pet.create(name: params["pet_name"])
    @owner.pets << @pet
    redirect to "pets/#{@pet.id}"
    # binding.pry
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
    else
      @owner = Owner.find(params["owner"]["id"])
    end
    @pet = Pet.find(params[:id])
    @pet.name = params["pet_name"]
    @pet.owner = @owner
    @owner.pets << @pet
    @pet.update
    redirect to "pets/#{@pet.id}"
  end
end