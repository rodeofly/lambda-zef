Array::unique = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output
delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms
    
#globals
[color_tab, ahead_vars, var_tab, renderPacks, renderArbor, looping, debug, infobox, tags, id, delta] = [ [], [], {},true, true, false, false, false, true, 0, 550 ]

ALPHABET = "abcdefghijklmnopqrstuvwxyz?"
CSS_COLOR_NAMES = ["Blue","Brown","BurlyWood","CadetBlue","Chartreuse","Chocolate","Coral","Yellow","Crimson","Cyan","DarkBlue","DarkCyan","DarkGoldenRod","DarkGray","DarkGreen","DarkKhaki","DarkMagenta","DarkOliveGreen","Darkorange","DarkOrchid","DarkRed","DarkSalmon","DarkSeaGreen","DarkSlateBlue","DarkSlateGrey","DeepPink","White","DimGray","DimGrey","DodgerBlue","FireBrick","FloralWhite","ForestGreen","Fuchsia","Gainsboro","GhostWhite","Gold","GoldenRod","Gray","Grey","Green","GreenYellow","HoneyDew","HotPink","IndianRed","Indigo","Ivory","Khaki","Lavender","LavenderBlush","LawnGreen","LemonChiffon","LightBlue","LightCoral","LightCyan","LightGoldenRodYellow","LightGray","LightGrey","LightGreen","LightPink","LightSalmon","LightSeaGreen","LightSkyBlue","LightSlateGray","LightSlateGrey","LightSteelBlue","LightYellow","Lime","LimeGreen","Linen","Magenta","Maroon","MediumAquaMarine","MediumBlue","MediumOrchid","MediumPurple","MediumSeaGreen","MediumSlateBlue","MediumSpringGreen","MediumTurquoise","MediumVioletRed","MidnightBlue","MintCream","MistyRose","Moccasin","NavajoWhite","Navy","OldLace","Olive","OliveDrab","Orange","OrangeRed","Orchid","PaleGoldenRod","PaleGreen","PaleTurquoise","PaleVioletRed","PapayaWhip","PeachPuff","Peru","Pink","Plum","PowderBlue","Purple","Red","RosyBrown","RoyalBlue","SaddleBrown","Salmon","SandyBrown","SeaGreen","SeaShell","Sienna","Silver","SkyBlue","SlateBlue","SlateGray","SlateGrey","Snow","SpringGreen","SteelBlue","Tan","Teal","Thistle","Tomato","Turquoise","Violet","Wheat","White","WhiteSmoke","YellowGreen"]
FUNCTION =
  "ZERO"  : "(λf.λx.x)"
  "ONE"   : "(λf.λx.(f x))"
  "TWO"   : "(λf.λx.(f(f x)))"
  "THREE" : "(λf.λx.(f(f(f x))))"
  "FOUR"  : "(λf.λx.(f(f(f(f x)))))"
  "FIVE"  : "(λf.λx.(f(f(f(f(f x))))))"
  "SIX"   : "(λf.λx.(f(f(f(f(f(f x)))))))"
  "SUCC"  : "(λn.λf.λx.f (n f x))"
  "PLUS"  : "(λm.λn.λf.λx.m f (n f x))"
  "MULT"  : "(λm.λn.λf.m (n f))"
  "POW"   : "(λb.λe.e b)"
  "PRED"  : "(λa.λf.λx.a (λg.λh.h (g f)) (λu.x) (λu.u))"
  "SUB"   : "(λm.λa. (a  (λn.λf.λx. n (λg.λh.h (g f)) (λu.x) (λu.u))) m)"
  "TRUE"  : "(λa.λb.a)"
  "FALSE" : "(λa.λb.b)"
  "AND"   : "(λp.λq.p q p)"
  "OR"    : "(λp.λq.p p q)"
  "NOT"   : "(λp.λa.λb.p b a)"
  "IF" : "(λp.λa.λb.p a b)"
  "ISZERO"     : "(λn.n (λx.(λa.λb.b)) (λa.λb.a))"
  "LEQ"        : "(λc.λp. (λq.q (λx.(λd.λe.e)) (λd.λe.d)) ((λm.λa. (a  (λn.λf.λx. n (λg.λh.h (g f)) (λu.x) (λu.u))) m) c p))"
  "Y"          : "(λf.( λx.( f (x x ) ) λx.( f (x x ) ) ) ) "
  "FACT"  : "(λn.λf. (n (λc.λi. (i (c (λf.λx (i f (f x))))))(λx. f) (λx. x)))"
  "PAIR"  : "(λx.λy.λz.z x y)"
  "FIRST" : "(λp.p (λx.λy.x))"
  "SECOND": "(λp.p (λx.λy.y))"
  "NIL"   : "((λx.λy.λz.z x y) (λa.λb.a) (λa.λb.a))"
  "ISNIL" : "(λp.p (λx.λy.x))"
  "CONS"  : "(λh.λt. (λx.λy.λz.z x y) (λa.λb.b) ((λx.λy.λz.z x y) h t))"
  "HEAD"  : "(λz. (λp.p (λx.λy.x)) ((λp.p (λx.λy.y)) z))"
  "TAIL"  : "(λz. (λp.p (λx.λy.y)) ((λp.p (λx.λy.y)) z))"
EXERCICES =
  "a" :
    "titre"            : 'Les items : "Le vieil alligator & les œufs"'
    "texte"            : "<p>Voilà un vieil alligator avec des œufs ! Le vieil alligator n'a plus faim, il a assez mangé.</p><p>Tous ce qu'il fait, c'est prendre soin de sa famille : ici ce sont des œufs et un autre vieil alligator qui garde deux oeufs!</p><p>Les œufs vont éclore et donner de nouvelles familles d'alligators.</p><p>Fais glisser un vieil alligator dans le panel, puis fais glisser le premier œuf sur le bout de la queue. Enfin, un à un, glisse des œufs et le vieil alligator les uns sur les autres pour les ajouter !</p>"
    "contenu-exercice" : "(f g h (i i) )"
    "contenu-eleve"    : "(?)"
    "compte-rendu"     : "()"
    "solution"         : "(f g h (i i) ) "

  "b" :
    "titre"            : 'Les items : "Les alligators affamés"'
    "texte"            : "<p>Voilà des alligators affamés...Les alligators affamés sont voraces. Ils vont manger tout ce qui est en devant eux (au point de mourir d'indigestion)! Mais ils sont aussi des alligators responsables, et comme les vieux alligators, ils gardent leurs familles.</p><p>Allez fais glisser !</p>"
    "contenu-exercice" : "λx.(λy.(λz.() ) ) "
    "contenu-eleve"    : "λx.()"
    "compte-rendu"     : "λ?"
    "solution"         : "λx.(λy.(λz.() ) ) "

  "c" :
    "titre"            : 'Les familles (1)'
    "texte"            : "<p>Voici une petite famille : un alligator garde son œuf !</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.e"
    "contenu-eleve"    : ""
    "compte-rendu"     : "λ?"
    "solution"         : "λe.(e ) "

  "d" :
    "titre"            : 'Les familles (2)'
    "texte"            : "<p>Voici une petite famille un peu plus grande.</p><p>Un alligator garde un autre alligator qui garde deux œufs. Ou on peut dire qu'un alligator garde un autre alligator qui est gardien des deux œufs.</p><p>Peux tu la recréer ?</p>"
    "contenu-exercice" : "λe.λf.e f"
    "contenu-eleve"    : ""
    "compte-rendu"     : "λ?"
    "solution"         : "λe.(λf.(e f ) ) "
    
  "e" :
    "titre"            : 'Les familles (3)'
    "texte"            : "<p>Voici une grande famille ! Nous avons un alligator jaune, un vert et un rose qui gardent cette famille. Ils gardent trois choses : un œuf vert, un vieux crocodile , et un œuf rose. Le vieil alligator, lui, garde un œuf jaune et un œuf vert.</p><p>Note bien que les œufs n'utilisent que les couleurs des alligators qui les surveillent . On ne peut pas avoir un œuf bleu sans qu'il y ait un alligator bleu au-dessus pour le garder.</p><p>Peux recréer cette famille ?</p>"
    "contenu-exercice" : "λh.λe.λg.(e (h e) g)"
    "contenu-eleve"    : "λh.λe.λg.?"
    "compte-rendu"     : "λ?. "
    "solution"         : "λh.(λe.(λg.(e (h e ) g ) ) ) "

  "f" :
    "titre"            : 'Manger'
    "texte"            : "<p>Attention, ça va se compliquer !</p><p>Voici deux familles, l'une à coté de l'autre. L'alligator vert est affamé, et il y a cette famille jaune juste en face de lui... Comme elle semble appétissante! La suite, tu la connais ?! Appuye sur le bouton (&#9658;).</p><p>Malheureusement , les yeux du crocodile vert étaient plus grands que son ventre. Il trop a mangé ! En mourant, il s'en va au paradis des alligator (ouf !). Mais, l'histoire ne se arrête pas là ; parce qu'une fois l'alligator vert mort, l'oeuf vert commence à éclore... Et étonnamment, il éclot exactement en ce que l'alligator vert avait mangé. C'est le miracle de la vie ! Maintenant, nous avons une nouvelle famille: un crocodile rouge gardant un alligator jaune et un oeuf rouge, et l'alligator jaune qui garde son œuf jaune. Mais cet alligator jaune à faim , et il y a un bel œuf rouge en face de lui. On y va encore une fois (&#9658;).</p><p>Pauvre alligator. Même un seul œuf est trop gros pour son estomac! L'alligator jaune meurt... mais encore une fois , l'œuf jaune commence à éclore ...Et il éclot dans exactement ce que l'alligator jaune avait mangé !</p><p>Maintenant, il n'y a plus rien pour quiconque à manger, donc nous pouvons arrêter là.</p>"
    "contenu-exercice" : "λe.(λf.(e f ) ) λh.(h ) "
    "contenu-eleve"    : ""
    "solution"         : ""
    "animation"        : "yes"

  "g" :
    "titre"            : 'La règle du "je te mange"'
    "texte"            : "<p>La règle de l'alimentation dit que s'il y a des familles côte-à-côté, l'alligator le plus en haut à gauche de la famille mange à sa droite.Puis , ce crocodile meurt . Mais si il gardait des oeufs de la même couleur que lui, chacun de ces oeufs va éclorent en ce qu'il a mangé</p>.<p>En continuant, l'alligator orange, mange la famille jaune. Ensuite, l'alligator vert en haut à gauche veut manger la famille à sa droite. Mais avant qu'elle ne puisse le faire , nous devons nous pencher sur la règle de couleur !</p><p>La règle de couleur dit que si un alligator est sur ​​le point de manger une famille, et que s'il y a une couleur qui apparaît dans les deux familles, nous devons changer cette couleur dans une famille avec une autre couleur. Ici, vert et rouge apparaissent à la fois la première et la seconde famille. Le changement de couleur est automatique. Une fois qu'ils ne partagent plus les mêmes couleurs, nous pouvons manger! Et manger!Et manger! Et manger, jusqu'à ce qu'il n'y ai rien de plus qui puisse être mangé .</p>"
    "contenu-exercice" : "λz.(λe.(z z e ) ) λe.(λf.(e f ) ) λh.(h ) "
    "contenu-eleve"    : ""
    "solution"         : ""
    "animation"        : "yes"

  "h" :
    "titre"            : 'La règle du vieil alligator'
    "texte"            : "<p>Il ne reste plus qu'une seule règle dans ce jeu, et elle est en lien avec les vieux alligators :</p>
<p>L'alligator supérieur gauche ici n'a pas faim. Il ne va rien manger du tout. Tout ce dont il se soucie est sa famille. Alors, comment meurt-il?</p>
<p>Il meurt quand il garde seulement une seule chose. À l'heure actuelle, Il est à la fois gardien d'une famille verte et d'une famille rouge. Ils ont besoin de lui pour prendre soin d'eux. Mais l'alligator vert a faim: il mange la famille rouge ...</p>
<p>Maintenant , le vieux crocodile ne garde plus qu'une seule famille. Cette famille peut prendre soin d'elle-même. Il n'est par conséquent plus nécessaire. Donc , il vieillit et meurt: C'est la vieille règle de l'âge!</p>
<p>Lorsque un vieux crocodile est juste gardait une seule chose , il meurt.</p><p>Pour finir, l'alligator rouge mange la famille jaune, et il ne reste plus rien qui puisse être mangé.</p>"
    "contenu-exercice" : "(λe.(e ) λf.(f ) ) λe.(e ) "
    "contenu-eleve"    : ""
    "solution"         : ""
    "animation"        : "yes"

  "i" :
    "titre"            : 'Challenge !'
    "texte"            : "<p>Voici deux familles. Elles s'appellent «Vrai» et «Faux» :</p><insert λe.(λf.(e ) ) λe.(λf.(f ) ) ><p>Et ici, une famille appelée «Non» : <insert λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) ></p><p>Lorsque «Non» mange «Vrai», il produit «Faux». Et lorsque «Non» mange «Faux», il produit «Vrai». De quelles couleurs devraient être les deux œufs?</p>"
    "contenu-exercice" : ""
    "contenu-eleve"    : "λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) (λe.λf.?) "
    "compte-rendu"     : "λh.(h λe.(λf.( ? ) ) λe.(λf.( ? ) ) ) "
    "solution"         : "λh.(h λe.(λf.( f ) ) λe.(λf.( e ) ) ) "
    "parse"            : "yes"

$ ->
  ###############################################
  #Preparation html - Construction de la console#
  ###############################################
  for letter,index in ALPHABET
    color_tab.push CSS_COLOR_NAMES[index]
    var_tab["#{letter}"] = CSS_COLOR_NAMES[index]
  $( "#exercices" ).append "<option value='#{key}'  data-id='#{key}'>Exercice #{key}</button>" for key of EXERCICES
  $( "#console"   ).append "<button id='#{key}' class='panel-button' data-type='fonction' data-lambda='#{value}'>#{key}</button>" for key,value of FUNCTION
  $( "#choose-color" ).append "<option value='#{ALPHABET[index]}' data-color='#{color}' data-class='ui-icon-script' >#{ALPHABET[index]}</option>" for color,index in color_tab
  
  open_def = $.Deferred()
  egg_def = $.Deferred()
  $.get "css/svg/egg.svg", (rawSvg) -> 
    $( ".item#egg-svg").append(document.importNode rawSvg.documentElement,true)
    $( ".item#egg-svg svg")[0].setAttribute('viewBox', '0 0 118 80')
    egg_def.resolve()
  , "xml"
  
  $.get "css/svg/open.svg", (rawSvg) -> 
    $( ".item#open-svg").append(document.importNode rawSvg.documentElement,true)
    $( ".item#open-svg svg")[0].setAttribute('viewBox', '0 0 300 124')
    open_def.resolve()
  , "xml"
  $.get "css/svg/vieux.svg", (rawSvg) -> 
    $( ".item#vieux-svg").append(document.importNode rawSvg.documentElement,true)
    $( ".item#vieux-svg svg")[0].setAttribute('viewBox', '0 0 300 124')
  , "xml"

  sys = arbor.ParticleSystem()
  sys.parameters
    repulsion : 2600
    stiffness : 1000
    friction  : 0
    gravity   : false
    precision : 0.015
  sys.renderer = Renderer("#viewport")
  sys.stop()
  
  
  ###############################################
  #Interface                            #
  ###############################################
  $.when(open_def,egg_def).done -> $( "#choose-color").trigger "selectmenuchange"
  
  resize = () ->
    value = parseInt $( "#amount-zoom" ).html()
    [simple, double] = ["#{value}px", "#{2*value}px"]
    s =
    """
    .lambda.priorite.dropped, .lambda.dropped { 
      min-width  : #{double};
      min-height : #{simple};
      padding-top: #{simple};
    }
    .variable.dropped { 
      width  : #{double};
      height : #{simple};
    }
    .dropped .svg-container {
      height : #{simple};
    }
    .definition_drop, .application_drop {
      width : #{simple};
      height: #{simple};
    }
    """
    $( "#restyler" ).text s
  
  $.widget "ui.selectmenu", $.extend {}, $.ui.selectmenu.prototype,
    _renderItem : ( ul, item ) ->
        color = var_tab[item.value]
        li = $( "<li>" ).css( "background-color", color  )
        s = "position:absolute;top:2%;left:2%;width:96%; height:96%;color:black;background:#{color};border-radius:100%;"
        $( "<span>", { text: item.value, style: s}).appendTo( li )
        return li.appendTo( ul )
    _renderMenu : ( ul, items ) ->
        that = this
        $.each items, ( index, item ) ->
          that._renderItemData( ul, item )
          $("#color").css("background" , item.element.attr("data-color")).attr("data-variable",item.value).attr "data-color", item.element.attr "data-color"
    
  $( "#choose-color" )
    .selectmenu
      appendTo : "#command-panel"
      open  : -> $("#game-container").addClass("stop-scrolling")
      close : -> $("#game-container").removeClass("stop-scrolling")
    .on "selectmenuchange", ( event, ui ) ->
      if ui?
        [color, variable] = [ui.item.element.attr("data-color"),ui.item.value]
      else
        [color, variable] = ["Blue","a"]
      $( "#panel-lambda" ).attr("data-variable", variable).html("λ#{variable}")
      $( "#panel-variable").attr("data-variable", variable).html("#{variable}")
      $( ".item#egg-svg > svg, .item#open-svg > svg" ).find(".skin").css("fill", color)
      $("#color")
        .css( "background"   , color )
        .attr("data-variable", variable)
        .attr("data-color"   , color )
  
  $( "#exercices" )
    .selectmenu( appendTo : "#top-panel" )    
    .on "selectmenuchange", ( event, ui ) -> 
      i = ui.item.element.attr( "data-id" )
      $( "#replay").attr "data-id", i
      preparer_exercice i

  $( "#slider-repulsion" ).slider
    range: "max"
    min   : 1
    max   : 3000
    step  : 10
    value : 2000
    slide : ( event, ui ) -> 
      $( "#amount-repulsion" ).html( ui.value )
      sys.parameters repulsion: ui.value          
  $( "#amount-repulsion" ).html("2000")

  
  $( "#slider-stiffness" ).slider
    range: "max"
    min   : 1
    max   : 3000
    step  : 10
    value : 1000
    slide : ( event, ui ) -> 
      $( "#amount-stiffness" ).html( ui.value )
      sys.parameters stiffness: ui.value           
  $( "#amount-stiffness" ).html("1000")
  
  $( "#slider-friction" ).slider
    range: "max"
    min   : 0
    max   : 1
    step  : 0.1
    value : 0
    slide : ( event, ui ) -> 
      $( "#amount-friction" ).html( ui.value )
      sys.parameters friction: ui.value           
  $( "#amount-friction" ).html("0") 

  $( "#slider-zoom" ).slider
    range: "max"
    min   : 1
    max   : 100
    step  : 1
    value : 40
    slide : ( event, ui ) -> 
      $( "#amount-zoom" ).html( ui.value )
      resize()          
  $( "#amount-zoom" ).html("40")
  resize()
  
  $( "#slider-animation" ).slider
    range: "max",
    min: 20,
    max: 6000,
    step: 20,
    value: 2000,
    slide: ( event, ui ) -> 
      $( "#amount-animation" ).html( ui.value )
      delta = ui.value    
  $( "#amount-animation" ).html( $( "#slider-animation" ).slider( "value" ) )
   
  $( "#console button" ).button()
  $('#close-console').button
    text: false
    icons: primary: 'ui-icon-close'
    
  $('#play').button
    text: false
    icons: primary: 'ui-icon-play' 
  $('#stop').button
    text: false
    icons: primary: 'ui-icon-stop' 
  $('#forward').button
    text: false
    icons: primary: 'ui-icon-seek-next'
  $('#clear').button
    text: false
    icons: primary: 'ui-icon-trash'
  $('#toggle-settings').button
    text: false
    icons: primary: 'ui-icon-wrench'
  
  $('#tags').button
    text: false
    icons: primary: 'ui-icon-tag'
  $('#infobox').button
    text: false
    icons: primary: 'ui-icon-comment'
  $('#toggle-console').button
    text: false
    icons: primary: 'ui-icon-calculator'
  $('#toggle-theory').button
    text: false
    icons: primary: 'ui-icon-script'
  $('#toggle-graph').button
    text: false
    icons: primary: 'ui-icon-image'
  
  $( "#layout" ).buttonset()
  
  $( "#croco-layout" ).on "click", ->
    sys.stop()
    renderArbor = renderPacks = false
    $( "#viewport, #chart, #toggle-graph-settings" ).hide()
    $( "#panels,  #toggle-croco-settings" ).show()
  
  $( "#packs-layout" ).on "click", ->
    sys.stop()
    renderArbor = false
    renderPacks = true
    $( "#viewport, #panels, #toggle-croco-settings, #toggle-graph-settings" ).hide()
    $( "#chart" ).show()
  
  $( "#graph-layout" ).on "click", ->
    renderArbor = true
    renderPacks = false
    render_viewport().init($("#root"))
    $( "#panels, #chart, #toggle-croco-settings" ).hide()
    $( "#viewport, #toggle-graph-settings" ).show() 
    
  $( "#toggle-croco-settings" ).on "click", -> $("#croco-settings").toggle()
  $( "#toggle-graph-settings" ).on "click", -> $("#graph-settings").toggle()
  $("#croco-settings, #graph-settings").toggle()
  
  $( "#toggle-console" ).on "click", -> $( "#console" ).toggle()
  $( "#close-console"  ).on "click", -> $( "#console" ).toggle()
  $( "#infobox" ).on "click", -> infobox = not infobox
  $( "#tags" ).on "click", -> 
    [selection, tags] = [$(".variable.dropped, .lambda.dropped"), not tags]
    if tags then selection.addClass( "show_pseudo" ) else selection.removeClass( "show_pseudo" )
  
  $( "#packs-layout" ).trigger "click"

 
  $( ".item" ).draggable
    helper : "clone"
    start:  (event, ui) -> $(ui.helper).addClass("ui-draggable-helper")
    stop : (event, ui) ->  $(this).show()
    #cursorAt : {top :  50, left : 150}
    
  ######################################################
  #Initialisation des items, dialog, couleurs et panels#
  ######################################################
  #items oeuf, croco, vieux croco draggable
 
  #Gestion du panel
  $( ".panel-button" ).on "click", ->
    switch $( this ).attr("data-type")
      when "lambda"   then $( "#prompt").val($( "#prompt").val() + "λ#{$( this ).attr('data-variable')}.")
      when "variable" then $( "#prompt").val($( "#prompt").val() + " #{$( this ).attr('data-variable')} ")
      when "open"     then $( "#prompt").val($( "#prompt").val() + "(")
      when "close"    then $( "#prompt").val($( "#prompt").val() + ")")
      when "fonction" then $("#prompt").val( $("#prompt").val() + " " + $(this).attr("data-lambda") )
      when "read"     then $("#prompt").val get_lambda_from $("#root")
      when "draw"     then draw_lambda_expression($( "#prompt").val())
      when "stop"  
        looping = false
        $( ".animation" ).prop("disabled",false)
      when "play"
        $( ".animation" ).prop("disabled",true)
        looping = false
        $( ".animation" ).prop("disabled",true)
        $( "#root .application_drop, #root .definition_drop" ).remove()
        go_one_step("#root")
      when "forward"
        $( ".animation" ).prop("disabled",true)
        $( "#root .application_drop, #root .definition_drop" ).remove()
        looping = true
        go_one_step("#root")
      when "clear"
        looping = false
        $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"
        $( "#prompt" ).val("")
        sys.eachNode (node) -> sys.pruneNode node
        make_dropped_droppable()   
      when "autoclose"
        parentheses = 0
        for letter,index in $("#prompt").val()
          switch letter
            when "(" then parentheses += 1
            when ")" then parentheses -= 1
        if parentheses < 0
          alert "il y a #{parentheses} parenthese(s) fermée en trop !)"
        else
          while parentheses > 0
            $( "#prompt").val($( "#prompt").val() + ")")
            parentheses -= 1

  
 
  
  draw_lambda_expression = (expression) ->
    insert_exp_into_div(expression,$("#root"))
    sys.eachNode (node) -> sys.pruneNode node
    render_viewport().init($("#root")) if renderArbor
    circle_pack_drawing('chart')
  
  $( "#help" ).dialog
    autoOpen    : false
    dialogClass : "noTitleStuff"
    width       : "auto"
    minHeight   : 0
    open        : (event, ui) -> delay 1000, -> $( "#help" ).dialog( "close" )
    autoResize: true
  help = (message, element) ->
    $( "#help" ).dialog "option",
      position :
        my: "center bottom"
        at: "center top"
        of: "##{element}"
    $( "#help" ).html message
    $( "#help" ).dialog( "open")    
  
  ###########################################################################################################################################################
  # Tutorial
  ###########################################################################################################################################################  
  $( "#console" ).draggable({containment: "#game-container"}).toggle()
  $( "#command-panel" ).draggable( {containment: "#game-container"})   
  
  #Exercice
  preparer_exercice = (id) ->
    $( ".animation" ).prop("disabled",false)
    exo = EXERCICES[id]   
    $( "#replay").attr "data-id", id
    $( "#exercice").attr "data-solution", exo["solution"]
    $( "#exercice").find("> .titre" ).html("<h1>#{exo['titre']}</h1>")   
    if exo["contenu-eleve"] isnt ""
      insert_exp_into_div(exo["contenu-eleve"], $("#root"))
    else
      $("#root" ).empty().append "<div id='root_definition' class='definition_drop'></div>"   
    if exo["contenu-exercice"] isnt "" then insert_exp_into_div exo["contenu-exercice"], $( "#contenu-exercice" )   
    if exo["animation"] is "yes" then $( "#animation").show() else $( "#animation").hide()    
    texte = exo['texte'] 
    reg = /<insert ([λ().\w\? ]*)>/
    while texte.match reg
      lambda = reg.exec(texte)
      insert_exp_into_div lambda[1], $("#exercice-texte")
      texte = texte.replace reg, $("#exercice-texte").html()
    $( "#exercice-texte" ).html("<p>#{texte}</p>")   
    if ("compte-rendu" of exo)
      texte = exo["compte-rendu"]
      insert_exp_into_div texte, $("#compte-rendu")
    $( "#exercice").show()
      
  $( "#exercice").hide()
  $( "#close-exercice").on "click", ->  $("#exercice").hide()  
  $( "#replay").on "click", () -> preparer_exercice $( this ).attr( "data-id" )
  $( "#animation" ).on "click", (event) -> 
    $( ".animation" ).prop("disabled",true)
    $( "#contenu-exercice .application_drop, #contenu-exercice .definition_drop" ).remove()
    go_one_step( "#contenu-exercice" )
  
  $( "#exercice .check" ).on "click", ->
    local_debug = true
    solution = $( "#exercice" ).attr("data-solution")
    resultat = get_lambda_from $("#compte-rendu")
    if resultat is solution
      alert "Super ! Si tu as tout compris, passe à l'exo suivant. Sinon rejoue !"
    else
      alert "Raté ! Essaye encore, n'oublie pas de cliquer sur 'rejouer'"
      #alert "[debug soluce : #{solution} ; eleve : #{resultat}]" if local_debug

  #Pour l'article
  $( "#theory" ).toggle()
  $( "#toggle-theory" ).on("click", -> $( "#theory" ).toggle())

  $( ".run-previous-code" ).on "click", ->
    js = CoffeeScript.compile($( this ).prev( ":first" ).text())
    eval(js)
  
  ###############################################################
  # LAMBDA CALCULUS START FROM HERE
  ###############################################################
  ###############################################################
  #Insert svg container as first child of an element, very specific to crocodile svg #
  ###############################################################
  parse = ($el) ->
    result = {}
    result['name'] = $el.attr('id')
    if $el.attr('data-color')?
      result['color'] = $el.attr 'data-color'
    else
      result['color'] = 'white'
    if $el.children('.dropped').length > 0
      result['children'] = []
      $el.children(".dropped").each (i, e) -> result['children'].push parse($(this))
    else
      result['size'] = 1
    return result

  circle_pack_drawing = (div_id) ->
    w = 960
    h = 960
    format = d3.format(',d')
    pack = d3.layout.pack().size([
      w - 4
      h - 4
    ]).value((d) ->
      d.size
    )

    $("##{div_id}").empty()
    vis = d3.select("##{div_id}").append('svg:svg').attr('width', w).attr('height', h).attr('class', 'pack').append('svg:g').attr('transform', 'translate(2, 2)')
    json = parse $(root)
    #alert JSON.stringify json
    node = vis.data([ json ]).selectAll('g.node').data(pack.nodes).enter().append('svg:g').attr('class', (d) ->
      if d.children then 'node' else 'leaf node'
    ).attr('transform', (d) ->
      'translate(' + d.x + ',' + d.y + ')'
    ).style 'fill', (d) ->  d.color
    node.append('svg:title').text (d) ->
      d.name + (if d.children then '' else ': ' + format(d.size))
    node.append('svg:circle').attr 'r', (d) ->
      d.r
    node.filter((d) ->
      !d.children
    ).append('svg:text').attr('text-anchor', 'middle').attr('dy', '.3em').text (d) ->
      d.name.substring 0, d.r / 3


  insert_item = (element) ->
    if (element.hasClass "lambda") and (element.hasClass "priorite") 
      $( ".item#vieux-svg").clone().removeClass("item").prependTo element
    else
      variable = element.attr "data-variable"
      element.attr "data-color", "#{var_tab[variable]}"
      if element.hasClass "variable"    
        $( ".item#egg-svg > svg" ).find(".skin").css("fill", element.attr "data-color")
        $( ".item#egg-svg ").clone().removeClass("item").prependTo element
      else
        $( ".item#open-svg > svg").find(".skin").css("fill", element.attr "data-color")
        $( ".item#open-svg").clone().removeClass("item").prependTo element
    element.addClass("definition_dropped") if variable is "?"

  ###############################################################################
  #Parse expression from a dom of div - svg container removed before            #
  ###############################################################################
  get_lambda_from = (root) ->
    exp = root.clone()
    exp.find("svg, .svg-container, .definition_drop, .application_drop").remove()
    exp = exp.html()
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="variable[\w \_\-]*" data-variable="([\w\?])" data-color="\w+"(?: style="[\w \;\:\-]*")?>\s*<\/div>/g, "$1 "
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="lambda[\w \_\-]*" data-variable="([\w\?])" data-color="\w+"(?: style="[\w \;\:\-]*")?>/g, "λ$1.("
    exp = exp.replace /<div(?: style="[\w \;\:\-]*")? id="\d*" class="lambda priorite[\w \_\-]*" data-variable="\(" data-color="white"(?: style="[\w \;\:\-]*")?>/g, "("
    exp = exp.replace(/<\/div>/g , ") ")
    exp = exp.replace(/\s{2,}/g, " ")
 ###########################################################################################################################################################
  #Insert expression in root from lambda expression exp, create dom and insert svg container
  ###########################################################################################################################################################
  insert_exp_into_div = (exp, root) ->
    expression = exp
    id = 0
    #make it easy to retrieve variables
    expression = expression.replace /([.( ])(([\w\?]))/g, "$1woot$2" 
    #lambdas
    local_debug = false
    while expression.match /λ/
      λ_index = 0
      while expression[λ_index] isnt "λ"
        λ_index += 1  
      λ_variable = λ_index+1
      current_index = λ_index+3
      switch expression[λ_index-1]     
        when "("
          alert "prototype : (λx. lambda ) = #{expression}" if local_debug
          parentheses = 1
          while ((parentheses > 0) and (current_index < expression.length) and (expression[current_index] isnt "<"))
            switch expression[current_index]
              when "(" then parentheses +=1
              when ")" then parentheses -=1
            current_index +=1
          alert "I got this : #{expression.substring(λ_index-1,current_index)}" if local_debug
          expression = expression.replace expression.substring(λ_index-1, current_index), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+3,current_index-1)}</div>"
          continue
        else 
          switch expression[current_index]
            when "("
              alert "prototype : λx.(lambda) = #{expression}" if local_debug
              parentheses = 1
              while ((parentheses > 0) and (current_index < expression.length) and (expression[current_index] isnt "<"))
                current_index += 1
                switch expression[current_index]
                  when "(" then parentheses +=1
                  when ")" then parentheses -=1

              alert "I got this : #{expression.substring(λ_index,current_index+1)}" if local_debug
              expression = expression.replace expression.substring(λ_index,current_index+1), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+4,current_index)}</div>"
              continue 
            else
              alert "prototype : λx.lambda = #{expression}" if local_debug
              
              while ((expression[current_index] isnt "<") and (current_index < expression.length))
                current_index += 1
              alert "I got this : #{expression.substring(λ_index,current_index)}" if local_debug
              expression = expression.replace expression.substring(λ_index,current_index), "<div id='' class='lambda dropped' data-variable='#{expression[λ_variable]}' data-color=''>#{expression.substring(λ_index+3,current_index)}</div>"
              continue           
    #most outer parentheses
    expression = expression.replace /[ ]*\(([^)]*\s?\)*)\)[ ]*/g, "<div id='' class='lambda priorite dropped' data-variable='parenthese' data-color='white' >$1</div>"   
    expression = expression.replace /\(/g, "<div id='' class='lambda priorite dropped' data-variable='parenthese' data-color='white'>"
    expression = expression.replace /\)/g, "</div>"
    expression = expression.replace /parenthese/g, "("
    #variables
    reg = /woot([\w\?])/g
    expression = expression.replace reg, "<div id='' class='variable dropped' data-variable='$1' data-color='' ></div>"
      #? inconnues
    #if expression.match /\?/
    #  expression = expression.replace /\?/g, "<div id='' class='lambda definition_drop' data-variable='?'></div>"
    expression = $('<div/>').html( expression ).contents()
    root.empty().append $( expression )
    #Insert alligators
    $( root ).find(".dropped").each ->
      $(this).attr "id", "#{id += 1}" 
      insert_item $(this)
    make_dropped_droppable()
    
  ###########################################################################################################################################################
  #Construction graphique
  ###########################################################################################################################################################
  inserer = (draggable, droppable) ->
    if draggable.hasClass("vieux-croco")
      [variable, color] = ["(", "white"]
    else 
      [variable, color] = [$("#color").attr("data-variable"), $("#color").attr("data-color")]
    if draggable.hasClass("egg")
      type = "variable"
    else if draggable.hasClass("croco")
        type = "lambda"
    else
      type ="lambda priorite"
    lambda = "<div id='#{id++}' class='#{type} dropped' data-variable='#{variable}' data-color='#{color}' ><div class='application_drop'></div></div>"
    lambda = $('<div/>').html(lambda).contents()
    if type isnt "variable"
      $( lambda ).prepend "<div class='definition_drop'></div>"
    insert_item $(lambda)
    if droppable.attr("data-variable") is "?" 
        droppable.find("> svg, > .svg-container").remove()
        droppable.after($(lambda))
        droppable.remove()
    else
      if droppable.hasClass( "definition_drop" )
        droppable.before $(lambda)
      else
        droppable.parent().after $(lambda)
      droppable.remove()
        
  make_dropped_droppable = () ->
    $( ".application_drop, .definition_drop, [data-variable='?']:not(#color)" ).droppable
      hoverClass: "ui-state-hover"
      accept : ".item"
      drop : ( event, ui ) ->
        inserer ui.draggable, $(this)
        make_dropped_droppable()
  make_dropped_droppable()
  
  ###########################################################################################################################################################
  #gestion d'une etape
  ###########################################################################################################################################################
  find_action_pointer = (root) ->
    #t0 = performance.now()
    [ahead_vars, local_debug] = [ [], false]
    pointer = $(root).children(".lambda:first()")
    while (pointer.length > 0) # TOP-LEFT RULE
      #console.log "stay for a loop with #{pointer.attr('data-variable')}" if local_debug
      if pointer.hasClass "priorite"  # On tombe sur un croco blanc
        break if (pointer.children(".dropped").length is 1) #il n'y en a qu'un -> ce croco blanc ne sert à rien
      else   # On tombe sur un croco de couleur
        break if  pointer.next().length > 0 # Il a des voisins a manger, mangeage !
        ahead_vars.push pointer.attr("data-variable") # Il n'en a pas, on cherche un croco dessous mais on reserve la couleur
      pointer = pointer.children(".lambda:first")
    #t1 = performance.now();
    #console.log("find_action_pointer took " + (t1 - t0) + " milliseconds.")
    return pointer
  
  color_rule_check = (pointer) ->
    #t0 = performance.now()
    get_vars = (tree) ->
      palette = []
      tree.find( "[data-variable]" ).addBack().filter("[data-variable]").not(".lambda.priorite").each -> palette.push $( this ).attr("data-variable")
      palette.unique()
    intersect = (a,b) -> a.filter (n) -> b.indexOf(n) isnt -1
    application = pointer.next()
    [function_vars, application_vars] = [get_vars( pointer ), get_vars( application )]
    #On regarde s'il y a des couleurs en commun  
    intersection = intersect(application_vars, function_vars) 
    #Mais on ne doit pas prendre celle qui se trouvaient au dessus dans la fonction
    intersection = (item for item in intersection when item not in ahead_vars)  
    #alert "[#{function_vars}], [#{application_vars}], [#{intersection}]"
    #Creation de la palette d'interpolation de variable
    palette = (item for item in ALPHABET[0..24] when item not in function_vars.concat application_vars)
    palette = palette[0..intersection.length-1]
    #t1 = performance.now();
    #console.log("color_rule_check took " + (t1 - t0) + " milliseconds.")
    return [intersection, palette]
  
  create_edges_for_heritier = (heritier) ->
    if heritier.length > 0
      local_debug = false
      console.log("CREATION DES LIENS POUR #{heritier.attr('id')}") if local_debug    
      
      target = heritier.attr("id")
      next = heritier.next(".dropped")
      if next.length > 0
        sys.addEdge next.attr("id"), target, {type : "arrow", directed : true, color : "white", weight : 1}
        console.log(next.attr("id") + " next-> " + target) if local_debug
      
      parent = heritier.parent()
      source = parent.attr("id")
      if ((source isnt "root") and source?)
        sys.addEdge source, target, {type : "arrow", directed : true, color : "grey", weight : 3}
        console.log(parent.attr("id") + " parent-> " + target) if local_debug
    
   transform_div_to_node = (div) -> 
    if div.hasClass("variable")
      [alias, variable, color, mass] = ["                         ", div.attr("data-variable"), div.attr("data-color"),1]
    else
      [alias, variable, color, mass] = ["", div.attr("data-variable"), div.attr("data-color") ,1]
    label = "#{alias}"
    sys.addNode div.attr("id"), {'color' : color, 'shape' : 'dot', 'label' : label, 'mass' : mass }
       
  render_viewport = () ->
    init : (pointer) ->
      local_debug = true
      console.log("init") if local_debug 
      particles = $( "#root" ).find(".dropped")      
      if particles.length > 0
        branch = {nodes:{}, edges:[]}
        particles.each ->
          transform_div_to_node($(this))
          create_edges_for_heritier( $(this))
        find_action_pointer $("#root") 
      sys.start()

  go_one_step = (root, button) ->
    local_debug = false
        
    make_generation_stuff = (div, deferred = $.Deferred()) ->
      t0 = performance.now()
      help("Partir", pointer.attr "id") if infobox
      $(div).children(".svg-container").remove()
      $(div).replaceWith $(div).contents()
      ###################################################################################################
      if renderArbor
        $( root ).find(".dropped").each -> create_edges_for_heritier( $(this) ) 
        sys.pruneNode( $(div).attr "id" )
      ###################################################################################################
      t1 = performance.now()
      console.log("make_generation_stuff: " + Math.floor(t1 - t0) + " ms")
      deferred.resolve()

    egg_fill_with = (egg, application,index,n) ->
      console.log("step 5 : ECLOSION DES OEUFS !") if local_debug
      #t0 = performance.now()
      #t1 = performance.now()
      #console.log("make_generation_stuff: " + Math.floor(t1 - t0) + " ms")
      switch index 
        when n-1
          appClone = application
          ###################################################################################################
          if renderArbor
            app_id = application.attr("id")
            sys.pruneEdge(edge) for edge in sys.getEdgesFrom(app_id) 
            sys.pruneEdge(edge) for edge in sys.getEdgesTo(app_id) 
          ###################################################################################################                      
        else
          appClone = application.clone()
          appClone.find(".dropped").addBack(".dropped").each -> $(this).attr "id", id += 1       
      $(egg).append appClone
      ###################################################################################################
      if renderArbor
        if appClone.length > 0
          appClone.find(".dropped").addBack(".dropped").each -> transform_div_to_node( $(this) ) 
          $( egg ).find(".dropped").each -> create_edges_for_heritier( $(this) )    
      ###################################################################################################   
      make_generation_stuff($(egg))
                     
    remove_app = (application) ->
      help( "Aucun oeuf", "root") if infobox
      ###################################################################################################  
      if renderArbor             
        console.log "cas 2 : pas d'oeuf, on retire l'application, et le suivant est connecté" if local_debug     
        application.find(".dropped").addBack().filter(".dropped").each -> sys.pruneNode( $(this).attr("id") )  
      ################################################################################################### 
      application.find("svg").remove()
      application.remove()
 
    step1 = $.Deferred()
    step2 = $.Deferred()
    step3 = $.Deferred()
    step4 = $.Deferred()
    
    #STEP 2 : regle du vieil alligator inutile
    step1.done (pointer) ->
      if (pointer.hasClass "priorite") and (pointer.children(".dropped").length < 2)       
        help( "Ce vieil alligator ne sert plus à rien !", pointer.attr("id")) if infobox    
        make_generation_stuff(pointer,step2)
      else
        step2.resolve()
        
    #STEP 3 : regle de la couleur
    step2.done () ->     
      pointer = find_action_pointer root 
      [intersection, palette] = color_rule_check(pointer)  
      if intersection.length > 0
        help( "Règle de la couleur !", pointer.attr("id")) if infobox
        #t0 = performance.now()
        #Pour chacune des couleurs de la fonction on va echanger dans l'application avec une couleur disponible de la palette 
        application = pointer.next(".dropped")
        for letter, letter_index in intersection
          selection = application.find( "[data-variable='#{letter}']").addBack("[data-variable='#{letter}']")
          if selection.length > 0
            selection.each ->           
              new_var = palette[letter_index]
              color =  var_tab[new_var]
              $(this).attr("data-variable", new_var)
              $(this).attr("data-color", color)
              $(this).find("> .svg-container .skin").css("fill", color) 
              ###################################################################################################    
              if renderArbor
                sys.tweenNode( $(this).attr("id"), delta/1000, {color: color} )       
              ###################################################################################################
              circle_pack_drawing('chart')
              delay delta, -> step3.resolve(pointer)
        #$(root).hide().show("fast")
        #t1 = performance.now()
        #console.log("change color elements took " + (t1 - t0) + " milliseconds.")
      else
        step3.resolve(pointer)
    
    #STEP 4 : EATING RULE
    step3.done (pointer) ->   
      if (pointer.hasClass "lambda") and (pointer.attr("data-color") isnt "white") and (pointer.next().length > 0)
        #On va faire reapparaitre l'application à chaque oeuf
        help("éclosion", "root") if infobox
        variable = pointer.attr("data-variable")
        eggs = pointer.find( ".variable.dropped[data-variable=#{variable}]"  )  
        application = pointer.next() 
        
        switch eggs.length
          when 0
            remove_app(application)
          else   
            eggs.each (index, egg) -> egg_fill_with(egg, application,index,eggs.length)    
        make_generation_stuff(pointer,step4)
      else
        step4.resolve()
    
    #STEP 5 : LOOPING ?!
    step4.done () ->   
    
      
       
      if renderArbor
        pointer = find_action_pointer root
        if pointer?
          edges = sys.getEdgesTo pointer.attr("id")
          edges.forEach (edge) ->
            sys.tweenEdge(edge, delta/1000, {weight : 10})
      circle_pack_drawing('chart')    
      delay delta, ->
        
        if looping
          go_one_step(root)
        else 
          $( ".animation" ).prop("disabled",false)
       
    #INIT : Find action croco !    
    action_croco = find_action_pointer root 
    if action_croco.length > 0
      step1.resolve(action_croco)
    else
     #alert "Plus rien à faire !"
     $( ".animation" ).prop("disabled",false)  
     
     
    
   
    

    
    
