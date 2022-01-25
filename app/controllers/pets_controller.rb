class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 

    if params[:owner][:name].empty?
      @owner = Owner.find_by(id: params[:pets][:owner_id])
      @pet = Pet.create(params[:pets])
      @pet.owner = @owner
      @pet.save
    elsif !params[:owner][:name].empty?
      @pet = Pet.create(params[:pets])
      @pet.owner = Owner.create(params[:owner])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])

    erb :'/pets/show'
   
  end

  patch '/pets/:id' do 
  
    @pet = Pet.find(params[:id])

    if params[:owner][:name].empty?
      @pet.update(params[:pet])
      @pet.save
    else
      @owner = Owner.create(params[:owner])
      @pet.update(params[:pet])
      @pet.owner = @owner
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @owners = Owner.all
    @pet = Pet.find(params[:id])


    erb :'/pets/edit'
  end

end