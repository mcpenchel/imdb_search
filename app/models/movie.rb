class Movie < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :syllabus]

  belongs_to :director

  pg_search_scope :search_by_title_and_syllabus,
    against: [ :title, :syllabus ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  pg_search_scope :global_search,
    against: [ :title, :syllabus ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }

end
