# Homepage (Root path)
get '/' do
  @all_players = Player.all
  erb :index
end

get '/players/new' do
  @player = Player.new
  erb :'/players/new'
end

post '/players/new' do
  @player = Player.new(name: params[:name], points: params[:points])
  @player.save
  @question = Question.new(question: params[:question], player_id: @player.id)
  @question.save
  redirect '/'
end

get '/question/one' do
  @player = Player.order(:id)[0]
  @question = Question.find_by(player_id: @player.id)
  @other_players = Player.where.not(id: @player.id)
  @answer = Answer.new
  @all_answer = Answer.where(question_id:@question.id)
  erb :question
  
end

post '/question/:question_id/answers' do 
  @answer = Answer.create(
    question_id: params[:question_id],
    answer: params[:answer],
    player_id: params[:other_player_id]
    )
  redirect '/question/one'
end

