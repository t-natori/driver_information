class Publics::PostsController < ApplicationController
  before_action :authenticate_customer!,except:  [:show]
  
  def new
  end

  def index
  end

  def show
  end

  def edit
  end
end
