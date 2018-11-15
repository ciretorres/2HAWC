import xml.etree.ElementTree as ET
import csv

tree = ET.parse("2HWC.xml")
root = tree.getroot()

# open a file for writing

catalogue = open('2HWC.csv', 'w')

# create the csv writer object

csvwriter = csv.writer(catalogue)
header = []

count = 0
for member in root.findall('source'):
	source = []
	if count == 0:
		name = member.find('name').tag
		header.append( name )
		longitude = member.find('l').tag
		header.append( longitude )
		latitude = member.find('b').tag
		header.append(latitude)
		RA = member.find('RA').tag
		header.append(RA)
		DEC = member.find('Dec').tag
		header.append(DEC)
		posSigma = member.find( 'position_uncertainty' ).tag
		header.append( posSigma )
		searchR = member.find( 'search_radius' ).tag
		header.append( searchR )
		TS = member.find('TS').tag
		header.append( TS )
		flux = member[7][0].find('flux').tag
		header.append(flux)
		flux_unc = member[7][0].find('flux_uncertainty').tag
		header.append(flux_unc)
		index=member[7][0].find('index').tag
		header.append(index)
		index_unc = member[7][0].find('index_uncertainty').tag
		header.append(index_unc)
		testedR = member[7][0].find('tested_radius').tag
		header.append(testedR)
		csvwriter.writerow(header)
		count =  count + 1

	name = member.find('name').text
	source.append(name)
	longitude = member.find('l').text
	source.append(longitude)
	latitude = member.find('b').text
	source.append(latitude)
	RA = member.find('RA').text
	source.append(RA)
	DEC = member.find('Dec').text
	source.append(DEC)
	posSigma = member.find('position_uncertainty').text
	source.append(posSigma)
	searchR = member.find('search_radius').text
	source.append('searchR')
	TS = member.find('TS').text
	source.append(TS)
	flux = member[7][0].find('flux').text
	source.append(flux)
	flux_unc = member[7][0].find('flux_uncertainty').text
	source.append(flux_unc)
	index = member[7][0].find('index').text
	source.append(index)
	index_unc = member[7][0].find('index_uncertainty').text
	source.append(index_unc)
	testedR = member[7][0].find('tested_radius').text
	source.append(testedR)
	csvwriter.writerow(source)
catalogue.close()