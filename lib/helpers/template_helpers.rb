
module Riobamba
  module TemplateHelpers

    def meta
      %{<meta charset="utf-8">
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <meta name="viewport" content="width=device-width, initial-scale=1">}
    end

    def title(value = nil)
      @title = value if value
      @title ? "Riobamba - #{@title}" : "Riobamba"
    end

    def js(*scripts)
      @js ||= []
      @js = @js + scripts
    end

    def javascripts(*argv)
      jss = []
      jss << argv
      jss << @js if @js
      jss.flatten.uniq.map do |s|
        "<script src=\"#{path_to_javascript s}\"></script>\n"
      end.join
    end

    def path_to_javascript(script)
      case script
        when :jquery then '/vendor/jquery/dist/jquery.min.js'
        else script.to_s
      end
    end
    def css(*sheets)
      @css ||= []
      @css = @css + sheets
    end

    def stylesheets(*argv)
      csss = []
      csss << argv
      csss << @css if @css
      csss.flatten.uniq.map do |s|
        "<link rel=\"stylesheet\" type=\"text\/css\" href=\"#{path_to_css s}\">\n"
      end.join
    end
   
    def path_to_css(sheet)
      case sheet
        when :normalize then "/vendor/normalize.css/normalize.css"
        when :milligram then '/vendor/milligram/dist/milligram.min.css'
        when :milligram_font then 'https://fonts.googleapis.com/css?family=Roboto:300,300italic,700,700italic'
        when :picnic then '/vendor/picnic/picnic.min.css'
        when :font_awesome then '/vendor/components-font-awesome/css/font-awesome.min.css'
        else sheet.to_s
      end
    end

    def ga(code)
      @ga = code
    end 

    def google_analytics
      if(@ga)
        %Q{<script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', '#{@ga}', 'auto');
          ga('send', 'pageview');
        </script>}
      end
    end
  end 
end