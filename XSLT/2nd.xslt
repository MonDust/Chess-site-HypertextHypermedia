<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8" />
                <title>Chess</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" href="chess_2.css" />
            </head>
            <body>
                <a class = "top"></a>
                <div id="wrapper">
                    <xsl:apply-templates select="chess_blog/title"/>
                    <div id="content">
                        <section>
                            <xsl:apply-templates select="chess_blog/main_information/website_links"/>
                            <xsl:apply-templates select="chess_blog/basics/welcome"/>
                            <h3 id="gallery_" ><xsl:value-of select="chess_blog/basics/title[@type='sub_title']"/></h3>
                            <xsl:apply-templates select="chess_blog/basics/rules"/>
                        </section>
                    </div>
                    <xsl:call-template name="top_link"/>
                </div>
                <xsl:apply-templates select="chess_blog/author_and_contact[1]"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="title">
        <xsl:choose>
            <xsl:when test="@type='main_title'">
                <header>
                    <h2><xsl:value-of select="."/></h2>
                </header>
            </xsl:when>
            <xsl:otherwise>
                <h2><xsl:value-of select="."/></h2>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="media">
        <xsl:choose>
            <xsl:when test="@gallery='yes'">
                <div class="gallery">
                    <xsl:apply-templates select="image"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <img id="{image/@type}" alt="{image/@name}" src="{image/@source}"><xsl:value-of select="image"/></img>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="image">
        <xsl:if test="@id='1'">
            <div class="one_board">
                <p><xsl:value-of select="."/></p>
                <img class="{@type}" alt="{@name}" src="{@source}"><xsl:value-of select="."/></img>
            </div>
        </xsl:if>
        <xsl:if test="@id='2'">
            <div class="two_board">
                <p><xsl:value-of select="."/></p>
                <img class="{@type}" alt="{@name}" src="{@source}"><xsl:value-of select="."/></img>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="menu">
        <h3><xsl:value-of select="title"/></h3>
        <ul>
            <xsl:apply-templates select="topic"/>
        </ul>
    </xsl:template>

    <xsl:template match="topic">
        <li class="main_menu"><a href = "main.xml"><xsl:value-of select="."/></a></li>
    </xsl:template>

    <xsl:template match="welcome">
        <h2><xsl:value-of select="."/></h2>
    </xsl:template>

    <xsl:template match="text">
        <div class="text">
            <xsl:apply-templates select="@kind"/>
            <p>
                <br></br><xsl:value-of select="."/>
            </p>
        </div>
    </xsl:template>

    <xsl:template match="website_links">
        <div>
            <xsl:apply-templates select="title"/>
            <xsl:apply-templates select="links_withmedia"/>
        </div>    
    </xsl:template>

    <xsl:template match="links_withmedia">
        <div id="websites">
            <xsl:apply-templates select="link" mode="withmedia"/>
        </div>
    </xsl:template>

    <xsl:template match="link" mode="withmedia">
        <p class="center"><a rel="noopener" href="{@source}" target="_blank"><img class="{image/@type}" alt="{image/@name}" src="{image/@source}"><xsl:value-of select="image"/></img></a></p>
    </xsl:template>

    <xsl:template match="tournaments">
        <xsl:for-each select="component">
            <xsl:sort select="@id" order="descending"/>
            <div class="text">
            <h1><xsl:number value="position()" format="1."/>
                <xsl:value-of select="title"/></h1>
            <p><xsl:value-of select="description"/></p>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="rules">
        <xsl:for-each select="piece">
            <xsl:sort select="@id" order="descending"/>
            <div class="text">
            <h1><xsl:number value="position()" format="1."/>
                <xsl:value-of select="name"/></h1>
            <p><xsl:value-of select="rule"/></p>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="author_and_contact">
        <footer>
            <br/>
            <xsl:value-of select="copyright"/><xsl:text>, </xsl:text><xsl:value-of select="names_and_surname"/><xsl:text> </xsl:text><xsl:value-of select="id_number"/>
            <br/>
            <xsl:text>Contact me! </xsl:text><xsl:number value="999999999" grouping-separator="-" grouping-size="3"/>
        </footer>
    </xsl:template>

    <xsl:template match="//@kind">
        <h1><xsl:value-of select="."/></h1>
    </xsl:template>

    <xsl:template name="top_link">
        <p><a title="GoTop" href = "#top" class="gotop"><svg width="70" height="70"><polygon id="triangle" points="35,10 10,60 60,60"/></svg></a></p>
    </xsl:template>

    
    <xsl:template name="navigation">
        <h3>HOME</h3>
        <ul>
            <li class="main_menu"><a href = "#top">START</a></li>
            <li class="main_menu"><a href = "#gallery_">BASICS</a></li>
        </ul>
    </xsl:template>

</xsl:stylesheet>