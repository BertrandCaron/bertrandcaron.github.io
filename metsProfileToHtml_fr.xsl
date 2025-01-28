<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mets="http://www.loc.gov/METS/" xmlns:premis="info:lc/xmlns/premis-v2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:spar_dc="http://bibnum.bnf.fr/ns/spar_dc" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mp="http://www.loc.gov/METS_Profile/v2" version="2.0"
    exclude-result-prefixes="xs mets premis xsi dc dcterms spar_dc xlink mp xhtml">
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
        doctype-public="-//W3C//DTD XHTML 1.1//EN" indent="yes"/>
    <!-- Définition de la langue (anglais et français gérés, anglais par défaut) -->
    <xsl:param name="language">fr</xsl:param>
    <xsl:template match="/mp:METS_Profile">
        <html>
            <xsl:attribute name="xml:lang" select="$language"/>
            <head>
                <!-- Titre de la page = élément title du profil -->
                <title>
                    <xsl:value-of select="mp:title[@xml:lang = $language]"/>
                </title>
                <!-- Utilisation de la feuille de style générique bibnum.css -->
                <link type="text/css" rel="stylesheet" href="../bibnum.css"/>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <!-- Date = date du profil -->
                <meta name="DC.date">
                    <xsl:attribute name="content">
                        <xsl:value-of select="mp:date"/>
                    </xsl:attribute>
                </meta>
                <!-- dc:creator = nom du contact de rôle "creator" dans le profil -->
                <meta name="DC.creator">
                    <xsl:attribute name="content">
                        <xsl:value-of select="mp:contact[@ROLE = 'creator']/mp:name"/>
                    </xsl:attribute>
                </meta>
                <!-- dc:publisher = nom du contact de rôle "maintenance agency" dans le profil -->
                <meta name="DC.publisher">
                    <xsl:attribute name="content">
                        <xsl:value-of
                            select="mp:contact[@ROLE = 'maintenance agency']/mp:institution"/>
                    </xsl:attribute>
                </meta>
            </head>
            <body>
                <!-- Création d'un tableau, la colonne de gauche étant réservée au logo BnF, au lien vers la page d'accueil bibnum.fr et au contact -->
                <table>
                    <tr>
                        <td valign="top">
                            <!-- Lien vers la page d'accueil bnf.fr -->
                            <a href="http://www.bnf.fr">
                                <!-- Logo BnF -->
                                <img src="http://bibnum.bnf.fr/bnf.gif" alt="bibnum.bnf.fr"/>
                            </a>
                            <br/><!-- Lien vers la page d'accueil bibnum.fr --> [<a
                                href="../index.html"><xsl:text>bibnum.bnf.fr</xsl:text></a><xsl:text>]</xsl:text><br/>
                            <!-- Contact = contact de rôle 'creator' dans le profil -->
                            <a>
                                <xsl:attribute name="href">mailto:<xsl:value-of
                                        select="mp:contact[@ROLE = 'creator']/mp:email"
                                    /></xsl:attribute><xsl:text>Contact</xsl:text></a>
                        </td>
                        <td>
                            <xsl:apply-templates/>
                        </td>
                    </tr>
                </table>
            </body>
        </html>
    </xsl:template>
    <!-- Titre de niveau 1 = élément title du profil -->
    <xsl:template match="mp:title[@xml:lang = $language]">
        <h1>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    <!-- Affichage de l'élément abstract -->
    <xsl:template match="mp:abstract[@xml:lang = $language]">
        <p>
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    <!-- Lien vers le schematron correspondant -->
    <xsl:template match="mp:related_profile[@RELATIONSHIP = 'isImplementedIn']">
        <p>
            <xsl:choose>
                <xsl:when test="$language = 'fr'">
                    <xsl:text>Le fichier schematron correspondant à ce profil est consultable </xsl:text><a>
                        <xsl:attribute name="href"><xsl:value-of select="@URI"
                        /></xsl:attribute>ici</a>. </xsl:when>
                <xsl:when test="$language = 'en'">
                    <xsl:text>The schematron file related to this profile is available </xsl:text><a>
                        <xsl:attribute name="href"><xsl:value-of select="@URI"
                        /></xsl:attribute>here</a>. </xsl:when>
                <xsl:otherwise>
                    <xsl:text>The schematron file related to this profile is available </xsl:text><a>
                        <xsl:attribute name="href"><xsl:value-of select="@URI"
                        /></xsl:attribute>here</a>. </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>
    <xsl:template match="mp:profile_context">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="mp:resource_model">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="xhtml:p[@xml:lang = $language]">
        <xsl:value-of select="."/>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Affichage des images (notamment pour le diagramme mentionné dans l'élément resource_model) -->
    <xsl:template match="xhtml:img">
        <br/>
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="@src"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="@alt"/>
            </xsl:attribute>
        </img>
    </xsl:template>
    <xsl:template match="mp:controlled_vocabularies">
        <h2>
            <xsl:choose>
                <xsl:when test="$language = 'fr'">
                    <xsl:text>Vocabulaires contrôlés</xsl:text>
                </xsl:when>
                <xsl:when test="$language = 'en'">
                    <xsl:text>Controlled vocabularies</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Controlled vocabularies</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </h2>
        <xsl:for-each select="mp:vocabulary">
            <xsl:choose>
                <xsl:when test="$language = 'fr'">
                    <h3>
                        <xsl:value-of select="mp:name[@xml:lang = 'fr']"/>
                    </h3>
                    <p>Les valeurs autorisées sont :</p>
                </xsl:when>
                <xsl:when test="$language = 'en'">
                    <h3>
                        <xsl:value-of select="mp:name[@xml:lang = 'en']"/>
                    </h3>
                    <p>Authorized values are:</p>
                </xsl:when>
                <xsl:otherwise>
                    <h3>
                        <xsl:value-of select="mp:name[@xml:lang = 'en']"/>
                    </h3>
                    <p>Authorized values are:</p>
                </xsl:otherwise>
            </xsl:choose>
            <ul>
                <xsl:for-each select="mp:values/mp:value">
                    <li>
                        <span class="soustitre">
                            <xsl:value-of select="string()"/>
                        </span>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="mp:structural_requirements">
        <h2>
            <xsl:choose>
                <xsl:when test="$language = 'fr'">
                    <xsl:text>Exigences de structure</xsl:text>
                </xsl:when>
                <xsl:when test="$language = 'en'">
                    <xsl:text>Structural requirements</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Structural requirements</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>
    <!-- Création d'un titre de niveau 3 par élément fils de l'élément structural_requirements -->
    <xsl:template match="mp:structural_requirements/*">
        <h3>
            <xsl:if test="self::node()[not(name() = 'multiSection')]">
                <xsl:choose>
                    <xsl:when test="$language = 'fr'">
                        <xsl:text>Règles pour la section '</xsl:text>
                    </xsl:when>
                    <xsl:when test="$language = 'en'">
                        <xsl:text>Rules for the section '</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Rules for the section '</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="name(.)"/>
                <xsl:text>'</xsl:text>
            </xsl:if>
            <xsl:if test="self::node()[name() = 'multiSection']">
                <xsl:choose>
                    <xsl:when test="$language = 'fr'">
                        <xsl:text>Règles concernant plusieurs sections</xsl:text>
                    </xsl:when>
                    <xsl:when test="$language = 'en'">
                        <xsl:text>Rules for different sections</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Rules for different sections</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
        </h3>
        <ul>
            <xsl:apply-templates/>
        </ul>

    </xsl:template>
    <!-- Traitement de chaque exigence -->
    <xsl:template match="mp:requirement">
        <li>
            <span class="soustitre">
                <xsl:choose>
                    <xsl:when test="$language = 'fr'">
                        <xsl:text>Règle numéro </xsl:text>
                    </xsl:when>
                    <xsl:when test="$language = 'en'">
                        <xsl:text>Rule number </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Rule number </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="substring-after(@ID, 'RULE.')"/>. </span>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="mp:description">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="node()"/>
</xsl:stylesheet>
