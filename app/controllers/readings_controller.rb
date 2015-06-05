class ReadingsController < ApplicationController
  load_and_authorize_resource

  def create
    @book = Book.find params[:book_id]

    current_user.send "read", @book, params[:behaviour]
    respond_to do |format|
      format.js
    end

    # current_user.send params[:behaviour], @book
    # respond_to do |format|
    #   format.js
    # end
  end

  def edit
    @book = @reading.book

    current_user.send "read", @book, params[:behaviour]
    respond_to do |format|
      format.js
    end

    # @book = @reading.book
    # current_user.send params[:behaviour], @book
    # respond_to do |format|
    #   format.js
    # end
  end

  def destroy
    @book = @reading.book
    current_user.unread @book
    respond_to do |format|
      format.js
    end
  end
end
