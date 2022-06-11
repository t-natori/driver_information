class Publics::CommentsController < ApplicationController
  before_action :authenticate_customer!
end
