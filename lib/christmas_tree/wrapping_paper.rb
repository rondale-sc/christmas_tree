module ChristmasTree
  class WrappingPaper
    attr_reader :decorator

    delegate :model, to: :decorator

    def initialize(decorator)
      @decorator = decorator
    end

    def tag(sym,&block)
      block.expressions.each do |exp|
        process_expression(exp)
      end
    end

    def process_expression(exp)
    end

    def content(&block)
      content = Content.new
      yield content
      content.to_s
    end

    class Content
      def initialize
        @value ||= []
      end

      def <<(string)
        @value << string
      end

      def to_s
        @value.join.html_safe
      end
    end
  end
end
