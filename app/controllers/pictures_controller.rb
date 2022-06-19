class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  # GET /pictures or /pictures.json
  def index
    @pictures = Picture.all.order(created_at: :desc)
  end

  # GET /pictures/1 or /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
    unless @picture.user == current_user
      redirect_to new_picture_path, notice: "You can't edit someone else's PicChum"
    end
  end

  # POST /pictures or /pictures.json
  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path, notice: "投稿完了"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /pictures/1 or /pictures/1.json
  def update
    respond_to do |format|
      if @picture.user != current_user
        redirect_to new_picture_path
      else
        if @picture.update(picture_params)
          format.html { redirect_to picture_url(@picture), notice: "Picture was successfully updated." }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /pictures/1 or /pictures/1.json
  def destroy
    if @picture.user != current_user
      redirect_to new_picture_path, notice: "You can't erase someone else's PicChum"
    else
      @picture.destroy
      respond_to do |format|
      format.html { redirect_to pictures_url, notice: "Picture was successfully destroyed." }
      format.json { head :no_content }
      end
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def picture_params
    params.require(:picture).permit(:image, :content, :image_cache)
  end
end
