require 'treetop'

module Mongoid
  module Oslc
    module OslcGrammar
      class GrammarNode < Treetop::Runtime::SyntaxNode
        def to_mongo_query
          elements[0].to_mongo_query
        end
      end

      class BinaryDecision < GrammarNode

        def to_mongo_query
          operand_1 = elements[0].to_mongo_query
          operand_2 = elements[2].to_mongo_query
          operand_1.merge(operand_2)
        end
      end

      class LogicalOperator < GrammarNode
      end

      class Field < GrammarNode
        def to_mongo_query
          text_content
        end
      end

      class Operator < GrammarNode
        OPERATORS = {
          "="   => "$in",
          "!="  => "$neq",
          ">"   => "$gt",
          ">="  => "$gte",
          "<"   => "$lt",
          "<="  => "$lte",
          "in"  => "$in"
        }

        def to_mongo_query
          OPERATORS[text_value]
        end

        def to_mongo_query_with_value(value)
          if text_value == "="
            value
          else
            { OPERATORS[text_value] => value }
          end
        end
      end

      class UriRefEsc < GrammarNode
        def to_mongo_query
          # TODO: an angle bracket-delimited URI reference in which > and \ are \-escaped.
          text_content
        end
      end

      class BooleanValue < GrammarNode
        def to_mongo_query
          text_value == "true"
        end
      end

      class StringEsc < GrammarNode
        def to_mongo_query
          text_value[1...-1]
        end
      end

      class Condition < GrammarNode
        def to_mongo_query
          field = OSLC_FIELDS_MAPPING[elements[0].text_value]
          value = elements[2].to_mongo_query
          operator_with_value = elements[1].to_mongo_query_with_value(value)
          { field => operator_with_value }
        end
      end
    end
  end
end
