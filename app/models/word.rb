class Word < ActiveRecord::Base
  belongs_to :category

  has_many :lesson, through: :results
  has_many :results
  has_many :answers
  has_many :user_word

  scope :all_words, -> user_id{}
  scope :learned, -> user_id{where "id in (select word_id from results where
    answer_id in (select id from answers where correct = \"t\") and
    lesson_id in (select id from lessons where user_id = #{user_id}))"}
  scope :not_learn, -> user_id{where "id not in (select word_id from results
    where answer_id in (select id from answers where correct = \"t\") and
    lesson_id in (select id from lessons where user_id = #{user_id}))"}

  def Word.import file, category_id
    CSV.foreach(file.path, headers: true) do |row|
      hash = row.to_hash
      @word = Word.create content: hash["Word"], category_id: category_id
      @word.answers.create content: hash["Answer1"], correct: hash["Correct1"]
      @word.answers.create content: hash["Answer2"], correct: hash["Correct2"]
      @word.answers.create content: hash["Answer3"], correct: hash["Correct3"]
      @word.answers.create content: hash["Answer4"], correct: hash["Correct4"]
    end
  end
end
