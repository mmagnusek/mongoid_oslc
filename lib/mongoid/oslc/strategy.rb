require 'treetop'
require 'mongoid/oslc/oslc_grammar'

module Mongoid
  module Oslc
    class Strategy
      attr_reader :parser

      def self.to_query(query, *args)
        options = { :verbose => true }
        options.merge!(args.extract_options!)

        Treetop.load File.join(File.dirname(__FILE__), "oslc_grammar")
        @parser = OslcGrammarParser.new

        tree = @parser.parse(query)
        raise Search::QueryParsingError.new(query, @parser.index) if tree.nil?

        clean_tree(tree)

        tree.to_mongo_query
      end

      private

      def self.clean_tree(root_node)
        return if(root_node.elements.nil?)
        root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
        root_node.elements.each {|node| self.clean_tree(node) }
      end
    end
  end
end
