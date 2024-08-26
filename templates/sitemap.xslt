<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:fn="http://www.w3.org/2005/xpath-functions"
>
	<xsl:output method="html" indent="yes" encoding="UTF-8" />
	<xsl:template match="/">
{%- set root = site.root %}
<html lang="en-GB">
	<head>
		<title>{{ this.title }}</title>
		<link href="{{ '/favicon.ico' | asseturl }}" rel="icon" />
		<meta content="width=device-width, initial-scale=1" name="viewport" />
		<meta name="color-scheme" content="light dark" />
		<meta name="theme-color" content="#038387" />
		<style><![CDATA[ @media(prefers-color-scheme:dark){html,body{background:black;color:white}}]]></style>
		{% for file in ["modern-normalize-0.5.0.css", "styles.scss.css"] %}
		<link rel="stylesheet" type="text/css" href="{{ 'css/{}'.format(file) | asseturl }}" />
		{%- endfor %}
	</head>
	<body>
		<main id="main">
			<header id="page-header">
				{% include "includes/breadcrumbs.html" %}
			</header>

			<section id="page-content">
				<h1>{{ this.title }}</h1>

				{{ this.body }}

				<ul>
					<xsl:for-each select="sitemap:urlset/sitemap:url">
						<xsl:variable name="sitemap_loc" select="sitemap:loc" />
						<xsl:variable name="sitemap_lastmod" select="sitemap:lastmod" />
						<li>
							<a href="{$sitemap_loc}">
								<xsl:value-of select="sitemap:loc" />
							</a>
							<xsl:if test="$sitemap_lastmod != ''">
								(Last Modified:
									{# TODO: Figure out why the stupid datetime functions don't work #}
									{# <xsl:value-of select="format-datetime(xs:datetime($sitemap_lastmod), '[Y0001][M01][D01]')" /> #}
									{# <xsl:value-of select="format-dateTime($sitemap_lastmod), '[Y0001][M01][D01]')" /> #}
									{# <xsl:value-of select="xs:dateTime(sitemap:lastmod)"/> #}
									{# <xsl:value-of select="sitemap:lastmod"/> #}
									{# <xsl:value-of select="replace(replace($sitemap_lastmod, 'T', ' '), '+00:00', 'UTC') "/> #}
									{# <xsl:value-of select="fn:replace($sitemap_lastmod, 'T', ' ')" /> #}
									<xsl:value-of select="substring($sitemap_lastmod,1,10)"/>
									<xsl:value-of select="' '"/>
									<xsl:value-of select="substring($sitemap_lastmod,12,8)"/>
									<xsl:variable name="timezone" select="substring($sitemap_lastmod, 20)" />
									<xsl:if test="$timezone = '+00:00'"> UTC</xsl:if>
									<xsl:if test="$timezone != '+00:00'"> <xsl:value-of select="$timezone"/></xsl:if>)
							</xsl:if>
						</li>
					</xsl:for-each>
				</ul>
				<p><xsl:value-of select="count(sitemap:urlset/sitemap:url)" /> pages</p>
			</section>

			{% include "includes/footer.html" %}
		</main>
	</body>
</html>
	</xsl:template>
</xsl:stylesheet>
