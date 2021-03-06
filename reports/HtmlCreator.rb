# TODO: need to make this thing understand the strucutre of the final HTML 
# directoreise so it can link to the root, etc
class HtmlCreator
  TemplateLocation = "reports/"

  def initialize
    @@template = DATA.read unless defined? @@template
    @variables = {}
  end

  def []=( key, value )
    @variables[key] = value
  end

  def []( key )
    @variables[key]
  end

  def writeToFile( path )
    File.write( path, getHtml() )
  end

  private

  def getHtml()
    html = @template.dup
    @varables.each do |name, value|
      name = '%' + name + '%'
      # FIXME TODO BUG!!!!! This does not account for gsub's insane behaviour!
      html.gsub!( name, value )
    end
    return html
  end

end

__END__
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head>
        <title>%TITLE% - TIX</title>
        <style type="text/css">
            * {
                padding: 0;
                margin: 0;
            }
            #header {
                border-bottom: solid 1px black;
                padding: 20px;
                background-color: #404040;
                color: #BBBBBB;
            }
            #subheader {
                color: #898989;
                font-size: 12pt;
            }

            #navbar {
                background-color: #999999;
                color: #000000;
                padding: 5px;
                border-bottom: 1px solid black;
                font-weight: bold;
            }
            #navbar a {
                color: #0033FF;
            }

            #content {
                width: 100%;
                padding: 10px;
            }
        </style>
    </head>
    <body>
        <div id="header">
            <h1><span style="color: #FFFFFF;">TIX:</span> %HEADER_TEXT%</h1>
            <h2 id="subheader">%SUBHEADER_TEXT%</h2>
        </div>
        <div id="navbar">
            <a href="%MAIN_ROOT_URL%">Root</a> -&gt;
            <a href="%MODULE_ROOT_URL%">%MODULE_NAME%</a>
            %EXTRA_NAV%
        </div>
        <div id="content">
            %CONTENT%
        </div>
    </body>
</html>
