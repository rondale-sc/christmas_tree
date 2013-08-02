module ChristmasTree
  class PresenterNotFoundError < StandardError; end
  class Ornament
    attr_reader :model

    def initialize(model)
      @model = model
    end

    def method_missing(method_name, *args, &block)
      if self.class.presenters.include? method_name
        presenter.send(method_name)
      else
        super
      end
    end

    def presenter
      @presenter ||= presenter_constant.new(self)
    end

    def presenter_constant
      presenter = presenter_name.constantize
    rescue NameError
      raise PresenterNotFoundError, "#{presenter_name} must be implemented to use ChristmasTree::Ornament.presents"
    end

    def presenter_name
      "#{self.class.to_s.gsub(/Decorator$/,'')}Presenter"
    end

    class << self
      def presents(*args)
        register_presenters(args)
      end

      def presenters
        @@presents ||= {}
        @@presents[self] ||= []
      end

      protected

      def register_presenters(args)
        args.each { |a| presenters << "to_#{a}".to_sym }
      end
    end
  end
end
