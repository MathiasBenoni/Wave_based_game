<map version="freeplane 1.12.1">
<!--To view this file, download free mind mapping software Freeplane from https://www.freeplane.org -->
<node TEXT="Shooting game" FOLDED="false" ID="ID_696401721" CREATED="1610381621824" MODIFIED="1734460289767" STYLE="oval">
<font SIZE="18"/>
<hook NAME="MapStyle">
    <properties edgeColorConfiguration="#808080ff,#ff0000ff,#0000ffff,#00ff00ff,#ff00ffff,#00ffffff,#7c0000ff,#00007cff,#007c00ff,#7c007cff,#007c7cff,#7c7c00ff" show_tags="UNDER_NODES" associatedTemplateLocation="template:/standard-1.6.mm" fit_to_viewport="false"/>
    <tags category_separator="::"/>

<map_styles>
<stylenode LOCALIZED_TEXT="styles.root_node" STYLE="oval" UNIFORM_SHAPE="true" VGAP_QUANTITY="24 pt">
<font SIZE="24"/>
<stylenode LOCALIZED_TEXT="styles.predefined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="default" ID="ID_271890427" ICON_SIZE="12 pt" COLOR="#000000" STYLE="fork">
<arrowlink SHAPE="CUBIC_CURVE" COLOR="#000000" WIDTH="2" TRANSPARENCY="200" DASH="" FONT_SIZE="9" FONT_FAMILY="SansSerif" DESTINATION="ID_271890427" STARTARROW="NONE" ENDARROW="DEFAULT"/>
<font NAME="SansSerif" SIZE="10" BOLD="false" ITALIC="false"/>
<richcontent TYPE="DETAILS" CONTENT-TYPE="plain/auto"/>
<richcontent TYPE="NOTE" CONTENT-TYPE="plain/auto"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.details"/>
<stylenode LOCALIZED_TEXT="defaultstyle.tags">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.attributes">
<font SIZE="9"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.note" COLOR="#000000" BACKGROUND_COLOR="#ffffff" TEXT_ALIGN="LEFT"/>
<stylenode LOCALIZED_TEXT="defaultstyle.floating">
<edge STYLE="hide_edge"/>
<cloud COLOR="#f0f0f0" SHAPE="ROUND_RECT"/>
</stylenode>
<stylenode LOCALIZED_TEXT="defaultstyle.selection" BACKGROUND_COLOR="#afd3f7" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#afd3f7"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.user-defined" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="styles.topic" COLOR="#18898b" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subtopic" COLOR="#cc3300" STYLE="fork">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.subsubtopic" COLOR="#669900">
<font NAME="Liberation Sans" SIZE="10" BOLD="true"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.important" ID="ID_67550811">
<icon BUILTIN="yes"/>
<arrowlink COLOR="#003399" TRANSPARENCY="255" DESTINATION="ID_67550811"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.flower" COLOR="#ffffff" BACKGROUND_COLOR="#255aba" STYLE="oval" TEXT_ALIGN="CENTER" BORDER_WIDTH_LIKE_EDGE="false" BORDER_WIDTH="22 pt" BORDER_COLOR_LIKE_EDGE="false" BORDER_COLOR="#f9d71c" BORDER_DASH_LIKE_EDGE="false" BORDER_DASH="CLOSE_DOTS" MAX_WIDTH="6 cm" MIN_WIDTH="3 cm"/>
</stylenode>
<stylenode LOCALIZED_TEXT="styles.AutomaticLayout" POSITION="bottom_or_right" STYLE="bubble">
<stylenode LOCALIZED_TEXT="AutomaticLayout.level.root" COLOR="#000000" STYLE="oval" SHAPE_HORIZONTAL_MARGIN="10 pt" SHAPE_VERTICAL_MARGIN="10 pt">
<font SIZE="18"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,1" COLOR="#0033ff">
<font SIZE="16"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,2" COLOR="#00b439">
<font SIZE="14"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,3" COLOR="#990000">
<font SIZE="12"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,4" COLOR="#111111">
<font SIZE="10"/>
</stylenode>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,5"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,6"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,7"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,8"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,9"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,10"/>
<stylenode LOCALIZED_TEXT="AutomaticLayout.level,11"/>
</stylenode>
</stylenode>
</map_styles>
</hook>
<hook NAME="AutomaticEdgeColor" COUNTER="15" RULE="ON_BRANCH_CREATION"/>
<node TEXT="Player" POSITION="bottom_or_right" ID="ID_518653716" CREATED="1734460290353" MODIFIED="1734460294650">
<edge COLOR="#ff0000"/>
<node TEXT="Controls" ID="ID_1292921235" CREATED="1734461034092" MODIFIED="1734461039561">
<node TEXT="WASD" ID="ID_432658775" CREATED="1734461039685" MODIFIED="1734461041432"/>
<node TEXT="Arrows" ID="ID_139262457" CREATED="1734461041685" MODIFIED="1734461047920"/>
</node>
<node TEXT="Node" ID="ID_620990648" CREATED="1734461407688" MODIFIED="1734461409081">
<node TEXT="CharacterBody2D" POSITION="bottom_or_right" ID="ID_1643975743" CREATED="1734461325980" MODIFIED="1734461332153"/>
<node TEXT="Area2D" ID="ID_58340320" CREATED="1734461500529" MODIFIED="1734461503389"/>
</node>
</node>
<node TEXT="Base" POSITION="top_or_left" ID="ID_149998924" CREATED="1734460295284" MODIFIED="1734460299700">
<edge COLOR="#0000ff"/>
<node TEXT="Can have defences" ID="ID_24935349" CREATED="1734460592962" MODIFIED="1734460966588">
<node TEXT="Starts without &apos;em" POSITION="top_or_left" ID="ID_1464582189" CREATED="1734460968632" MODIFIED="1734460978904"/>
</node>
<node TEXT="Node" ID="ID_1152983472" CREATED="1734461407688" MODIFIED="1734461409081">
<node TEXT="StaticBody2D" POSITION="top_or_left" ID="ID_107956730" CREATED="1734461369454" MODIFIED="1734461381179"/>
<node TEXT="Area2D" POSITION="top_or_left" ID="ID_1613071756" CREATED="1734461386218" MODIFIED="1734461390027"/>
</node>
</node>
<node TEXT="Enemies" POSITION="bottom_or_right" ID="ID_1552310612" CREATED="1734460300515" MODIFIED="1734460314110">
<edge COLOR="#00ff00"/>
<node TEXT="Wave based" ID="ID_3120684" CREATED="1734460894453" MODIFIED="1734460900019"/>
<node TEXT="Drops coins" ID="ID_1910961079" CREATED="1734460935886" MODIFIED="1734460944540"/>
<node TEXT="Node" ID="ID_502129863" CREATED="1734461407688" MODIFIED="1734461409081">
<node TEXT="Area2D" POSITION="bottom_or_right" ID="ID_986722593" CREATED="1734461336472" MODIFIED="1734461340086"/>
<node TEXT="CharacterBody2D" POSITION="bottom_or_right" ID="ID_718273733" CREATED="1734461392148" MODIFIED="1734461405993"/>
</node>
</node>
<node TEXT="Pistol" POSITION="top_or_left" ID="ID_1117736793" CREATED="1734460331624" MODIFIED="1734460435411">
<edge COLOR="#7c0000"/>
<node TEXT="Spinner etter cursor" ID="ID_1315954164" CREATED="1734460550042" MODIFIED="1734460564180"/>
<node TEXT="Node" ID="ID_1321768013" CREATED="1734461407688" MODIFIED="1734461409081">
<node TEXT="StaticBody2D" POSITION="top_or_left" ID="ID_988678845" CREATED="1734461350448" MODIFIED="1734461359494"/>
<node TEXT="Area2D" ID="ID_1777445414" CREATED="1734461509943" MODIFIED="1734461514940"/>
</node>
</node>
<node TEXT="Upgrades" POSITION="bottom_or_right" ID="ID_496637307" CREATED="1734460441260" MODIFIED="1734460444350">
<edge COLOR="#00007c"/>
<node TEXT="Base" ID="ID_598964026" CREATED="1734460609935" MODIFIED="1734460614132">
<node TEXT="Health" ID="ID_731566641" CREATED="1734460640856" MODIFIED="1734460642678"/>
<node TEXT="defense" ID="ID_1091396438" CREATED="1734460643240" MODIFIED="1734460658009"/>
</node>
<node TEXT="Pistol" ID="ID_1468884028" CREATED="1734460614443" MODIFIED="1734460617487">
<node TEXT="Shooting speed" ID="ID_820523563" CREATED="1734460659059" MODIFIED="1734460669667"/>
<node TEXT="Damage" ID="ID_1112681894" CREATED="1734460670051" MODIFIED="1734460684971"/>
<node TEXT="Critical hit chance?" ID="ID_531694631" CREATED="1734460881116" MODIFIED="1734460889434"/>
<node TEXT="Laser gun" ID="ID_1016238955" CREATED="1734723804149" MODIFIED="1734723807894">
<node TEXT="Fast bullet" ID="ID_1598166596" CREATED="1734723811864" MODIFIED="1734723817598">
<node TEXT="Red" ID="ID_1072142151" CREATED="1734723817814" MODIFIED="1734723819279"/>
</node>
</node>
</node>
<node TEXT="Player" ID="ID_558003977" CREATED="1734460617748" MODIFIED="1734460620696">
<node TEXT="Movement speed" ID="ID_1319993786" CREATED="1734460691863" MODIFIED="1734460695892"/>
<node TEXT="Health" ID="ID_1226631163" CREATED="1734460696306" MODIFIED="1734460865078"/>
</node>
</node>
<node TEXT="Game_mechanics" POSITION="top_or_left" ID="ID_1164300427" CREATED="1734460474466" MODIFIED="1734460495108">
<edge COLOR="#ff00ff"/>
<node TEXT="Wave based" ID="ID_1713276456" CREATED="1734460479447" MODIFIED="1734460501301">
<node TEXT="Between &apos;em" ID="ID_1887386880" CREATED="1734460908246" MODIFIED="1734460921334">
<node TEXT="Upgrades" ID="ID_1576989800" CREATED="1734460922013" MODIFIED="1734460931611"/>
</node>
</node>
<node TEXT="Linear learning" ID="ID_125858067" CREATED="1734460501837" MODIFIED="1734460544428"/>
<node TEXT="2D" ID="ID_888036172" CREATED="1734461106452" MODIFIED="1734461108640"/>
<node TEXT="Pixel art" ID="ID_1533159484" CREATED="1734461233728" MODIFIED="1734461237531"/>
</node>
<node TEXT="Map" POSITION="top_or_left" ID="ID_1892990239" CREATED="1734460457931" MODIFIED="1734460460141">
<edge COLOR="#00ff00"/>
<node TEXT="Top down" ID="ID_1861942258" CREATED="1734460460531" MODIFIED="1734460464843"/>
<node TEXT="Tilemap" ID="ID_1703933207" CREATED="1734461344473" MODIFIED="1734461347922"/>
<node TEXT="Terrain" POSITION="bottom_or_right" ID="ID_841601526" CREATED="1734460315248" MODIFIED="1734461364852">
<node TEXT="Big areas" ID="ID_931430634" CREATED="1734460574270" MODIFIED="1734460580382"/>
<node TEXT="Small areas" ID="ID_1284382022" CREATED="1734460582617" MODIFIED="1734460589843"/>
</node>
</node>
</node>
</map>
