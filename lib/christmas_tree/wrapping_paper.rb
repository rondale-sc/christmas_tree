module ChristmasTree
  class WrappingPaper
    attr_reader :decorator

    delegate :model, to: :decorator

    def initialize(decorator)
      @decorator = decorator
    end
  end
end
