sfdx force:source:push -u ${amicarci}
sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --resultformat tap --targetusername ${amicarci}