class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # def new
  #   @user = User.find(params[:user_id])
  #   @booking = Booking.new
  #   @path = [@customer, @booking]
  # end

  # # GET /bookings/1/edit
  # def edit
  #   @booking = Booking.find(params[:id])
  #   @user = @booking.user
  #   @path = @booking
  # end

  # GET /bookings/new
 def new
   @user = User.find(params[:user_id])
   @booking = Booking.new
 end

 # GET /bookings/1/edit
 def edit
   @booking = Booking.find(params[:id])
   @user = @booking.user
 end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    @booking.state = 'pending'
    @user = User.find(params[:booking][:user_id])

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking.user, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking.user }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking.user, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking.user }
      else
        format.html { rrender :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:day_of_week, :time, :recurring, :day_of_play, :user_id, :opponent_first, :opponent_last)
    end
end
