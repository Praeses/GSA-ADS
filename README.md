GSA-ADS
========================
## Site Link
[gsa-ads.praeses.com](http://gsa-ads.praeses.com)

## Project Description
BACKGROUND

Praeses followed agile development methodologies (Scrum) with this GSA ADS prototype. The agile approach is centered on the concept of delivering workable software in short increments (“sprints”) in constant collaboration with the customer. This contrasts with the Waterfall approach, which typically generates long, sequential phases of software delivery, which, if off the mark (for example, in defining requirements), often causes considerable delays and added cost to the solution.

Praeses’ use of agile methodologies allows the customer to utilize working software on a regular basis, thus enabling real-time field testing of the product and providing invaluable feedback to the software developers, all of which guides future development work. By giving the customer an earlier stake in outcomes, the agile methodology opens the door to making efficient real-time adjustments based on the changing priorities that are bound to occur, leading to a solution that best satisfies customer needs.

As described in the Technical Approach section below, the GSA ADS prototype developed in response to this RFQ served as an excellent example of the agile approach – demonstrating a good feedback cycle between the “customer” and development team, adapting to changing priorities based on discoveries with the openFDA API as well as changing RFQ deadlines and, ultimately, delivery of a working solution that satisfied the customer’s (changed) priorities.

TECHNICAL APPROACH

The objective of the GSA ADS technical deliverable is to simulate an agile customer request using the openFDA API to deliver data analysis. We decided to use D3.js for our charting engine, as the developers had experience in the library, and the skinnable nature allowed for easy customization. We also decided to use the DC.js library, which enabled the charted data to be crossfiltered in realtime. The openFDA API syntax was also very straightforward and easy to utilize. However, during our first sprint, we noticed several limitations to the API, namely: caps on the number of requests per minute (40) and per day (1000); a cap on the number of records the API could deliver at one time (100); and a cap on the number of records the API could page through (5000). This means that given a limited search filter, it was impossible to retrieve the entire dataset (maximum 5100). It also meant that we would have to put limits on what our customer could ask for, a very realistic condition that we soon realized would lend itself nicely to the agile methodologies.

The simulated customer first asked for a chart of drug events per day, and using the DC.js dimensional charting library, to link the data in that chart to live breakdowns of drug events by age and location. We knew almost immediately that this was a request that was unresolvable given the due date of the RFQ. In order to link the data, the counts would have to be collated with age and location breakdowns for every event in the openFDA drug database by day. We were able to increase the limitation on requests per minute and day by acquiring an API key, but given the sheer number of results in the database for the search criteria (over 4.5 million), and the limit on paged results (500000), there was no way to get enough data to correlate the live graphs within the customer (i.e., RFQ) timeframe. We attempted to build a back end caching system that could, given the static nature of the openFDA API, cache results overnight, allowing us to query from a local repository. But once implemented, we again met issues when the openFDA site, due to overburdened servers, again had restrictions on the number of pages (5000 skipped records) any query could request.

We met with our “customer” and explained the technical limitations, and he acquiesced, loosening his requirements of live, collated charts. We then built 4 dedicated queries, the first retrieving the total event counts per day, and the other three retrieving event counts per drug, location, and age. We utilized the back end caching system to collate the breakdowns of drug, location, and age, due to the inability of the openFDA API to retrieve more than one count per query, and once complete, had 4 local repositories of collated data counts available for front end development.

Once the data was fully available, developing the charts was fairly straightforward. The charting engines made light work of displaying the data, and we were able to easily meet the revised customer requests for four distinct charts showing drug events by age, name, location and day.

## Build Status
[![Build Status](https://travis-ci.org/Praeses/GSA-ADS.svg?branch=dev)](https://travis-ci.org/Praeses/GSA-ADS)

## Build and Deployment Instructions
[BUILD.md](https://github.com/Praeses/GSA-ADS/blob/master/BUILD.md)

