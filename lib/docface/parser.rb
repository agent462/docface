require 'kramdown'

module DocFace
  class Parser
    def to_html(markdown)
      Kramdown::Document.new(markdown, {:enable_coderay => true, :auto_ids => true}).to_html
    end
    def to_latex(markdown)
      Kramdown::Document.new(markdown, {:enable_coderay => true, :auto_ids => true}).to_latex
    end
  end
end
