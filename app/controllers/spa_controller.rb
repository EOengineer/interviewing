class SpaController < ApplicationController
  layout 'react_app'

  before_action :authenticate_user!

  def index
    @user = current_user
  end
end
