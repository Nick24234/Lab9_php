class PagesController < ApplicationController

  skip_before_action :authenticate_user!, only: [:home, :about, :support, :support_result]
  def home

  end

  def about

  end

  def support

  end

  def support_result

    @name = params[:name]
    @subject = params[:subject]
    @message = params[:message]
  end
end

