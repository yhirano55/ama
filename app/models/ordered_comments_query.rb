class OrderedCommentsQuery
  SORT_OPTIONS = %w[oldest newest most_liked].freeze

  def initialize(relation = Comment.all, params = {})
    @relation = relation
    @params = params
  end

  def all
    relation.public_send(sort_by)
  end

  private

    attr_reader :relation, :params

    def sort_by
      params[:sort].presence_in(SORT_OPTIONS) || :newest
    end
end
