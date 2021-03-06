class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    @id = current_user.id

    @image = User.find(@id).image

    @chats = Chat.where(female_id: @id).or(Chat.where(male_id: @id))



  end

  # GET /chats/1
  # GET /chats/1.json
  def show
    # Chatのidを指定しDBから指定したChat idのMessageにアクセス。
    #  message_typeからtextかimageを出力するか決定し、userと一緒に出力
    
    @chat_id = params[:id].to_i
    chat = Chat.find(@chat_id)

    @my_id = current_user.id

    if @my_id != chat.female_id
      @to_id = chat.female_id
    else
      @to_id = chat.male_id
    end

    @messages = Message.where(chat_id: @chat_id)

  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats
  # POST /chats.json
  def create
    # 二人のuser_idを受け取り、Chatのインスタンスを作り、DBに保存
    #
    @chat = Chat.new(chat_params)

    if @chat.save!

    else

    end

    # respond_to do |format|
    #   if @chat.save
    #     format.html { redirect_to @chat, notice: 'Chat was successfully created.' }
    #     format.json { render :show, status: :created, location: @chat }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @chat.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /chats/1
  # PATCH/PUT /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to @chat, notice: 'Chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1
  # DELETE /chats/1.json
  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to chats_url, notice: 'Chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:male_id, :female_id)
    end
end
