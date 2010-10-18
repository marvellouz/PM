<?xml version='1.0' encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
<!--Show comments (annotations in pdf)-->
<xsl:param name="show.comments" select="1"/>
<!-- We want the TOC links in the titles, and in blue. -->
<!-- colorforlinks is defined in mystyle.sty -->
<xsl:param name="latex.hyperparam">colorlinks,linkcolor=colorforlinks,pdfstartview=FitH</xsl:param>
<!-- Hide collaboration table -->
<xsl:param name="doc.collab.show">0</xsl:param>
<xsl:param name="draft.mode">no</xsl:param>
<!-- Set up for Bulgarian.  -->
<!--Don't set latex.unicode.use to 1 with xetex!-->
<!--<xsl:param name="latex.unicode.use">1</xsl:param>-->
<xsl:param name="latex.babel.language">bulgarian</xsl:param>
<!--<xsl:param name="latex.output.revhistory">0</xsl:param>-->
<xsl:param name="co.linkends.show" select="'0'"/>
<xsl:param name="doc.pdfauthor.show">1</xsl:param>
<!--<xsl:param name="glossterm.auto.link" select="1"/>-->

<!--Switch to polyglossia, which is an alternative to Babel, because Babel is problematic with the xetex backend-->
<xsl:template name="babel.setup">
  <!-- babel use? -->
  <xsl:if test="$latex.babel.use='1'">
    <xsl:variable name="babel">
      <xsl:call-template name="babel.language">
        <xsl:with-param name="lang">
          <xsl:call-template name="l10n.language">
            <xsl:with-param name="target" select="(/set|/book|/article)[1]"/>
            <xsl:with-param name="xref-context" select="true()"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="$babel!=''">
      <xsl:text>\usepackage[</xsl:text>
      <xsl:value-of select="$babel"/>
      <xsl:text>]{polyglossia}&#10;</xsl:text>
      <!--<xsl:text>\usepackage{cmap}&#10;</xsl:text>-->
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template match="procedure/title">
  <xsl:text>{\scshape{\bfseries </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>\addcontentsline{toc}{subsection}{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
  <!-- A dirty hack. Will break if we actually have subsections -->
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="procedure">
  <xsl:call-template name="label.id"/>
  <xsl:text>\begin{usecase}</xsl:text>
    <xsl:apply-templates select="*[not(self::step)]"/>
  <!--<xsl:value-of select="title"/>-->
  <xsl:if test="./step">
    <xsl:text>\textbf{Сценарий}</xsl:text>
  </xsl:if>
  <xsl:if test="./step">
    <xsl:text>\begin{enumerate}&#10;</xsl:text>
    <xsl:apply-templates select="step"/>
    <xsl:text>\end{enumerate}&#10;</xsl:text>
  </xsl:if>
  <xsl:text>\end{usecase}</xsl:text>
</xsl:template>

<xsl:template match="step">
  <xsl:if test="not(parent::stepalternatives|parent::substeps)">
    <xsl:text>\setcounter{alternative}{0}</xsl:text>
  </xsl:if>
  <xsl:text>\item</xsl:text><xsl:if test="parent::stepalternatives"><xsl:text>[*]</xsl:text></xsl:if><xsl:text>{</xsl:text>
  <xsl:call-template name="label.id"/>
  <xsl:apply-templates/>
  <xsl:text>}&#10;</xsl:text>
</xsl:template>

<xsl:template match="step/stepalternatives">
  <xsl:text>
    \medskip
    \stepcounter{alternative}
    \textbf{Алтернатива UC-\arabic{usecase}/\arabic{enumi}-A\arabic{alternative}}
  </xsl:text>
  <xsl:apply-templates select="*[not(self::step)]"/>
  <xsl:if test="./step">
    <xsl:text>\begin{enumerate}&#10;</xsl:text>
      <xsl:apply-templates select="./step"/>
    <xsl:text>\end{enumerate}&#10;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="authorgroup">
  <xsl:variable name="string">
    <xsl:for-each select="author">
      <xsl:value-of select="firstname"/><xsl:text> </xsl:text> <xsl:value-of select="surname"/>
      <xsl:text>
        \textit{</xsl:text><xsl:value-of select="authorblurb/para"/><xsl:text>}</xsl:text>
      <xsl:if test="email">
        <xsl:text> \text{\small{(\href{mailto:</xsl:text><xsl:value-of select="email"/><xsl:text>}{</xsl:text><xsl:value-of select="email"/><xsl:text>})}}</xsl:text>
      </xsl:if>
      <xsl:if test="position()!=last()">
        <xsl:text>,\\</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:value-of select="normalize-space($string)"/>
</xsl:template>

<xsl:template match="glossdiv" mode="xref-to">
  <xsl:param name="referrer"/>
  <xsl:call-template name="hyperlink.markup">
    <xsl:with-param name="referrer" select="$referrer"/>
    <xsl:with-param name="linkend" select="(@id|@xml:id)[1]"/>
    <xsl:with-param name="text">
      <xsl:call-template name="inline.italicseq">
        <xsl:with-param name="content">
          <xsl:apply-templates select="title" mode="xref.text"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="procedure|figure" mode="xref-to">
  <xsl:param name="referrer"/>
  <xsl:call-template name="hyperlink.markup">
    <xsl:with-param name="referrer" select="$referrer"/>
    <xsl:with-param name="linkend" select="(@id|@xml:id)[1]"/>

    <xsl:with-param name="text">
      <xsl:call-template name="inline.italicseq">
        <xsl:with-param name="content">
          <xsl:apply-templates select="title" mode="xref.text"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
