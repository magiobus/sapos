class UsersController < ApplicationController
  before_filter :auth_required
  def index
  end
end
