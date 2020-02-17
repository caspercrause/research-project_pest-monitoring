# research-project_pest-monitoring

In an effort to aid local farmers improve their yields, I took it upon myself to help predict the success of mating disruptions for one the fruit industries biggest pests - ___Fruit Fly and False Codling Moth___

Mating disruption (MD) is a pest management technique designed to control certain insect pests by introducing artificial stimuli that confuse the individuals and disrupt mate localization and/or courtship, thus preventing mating and blocking the reproductive cycle.

It is commonly executed every three months. I would like to predict compare the results of the pest count for:
1.	When mating disruption has been applied
2.	When mating disruption has not been applied.

I've attached a few imaginary datasets. I attempt to create a column that looks at the dates that MD has been applied and evaluates the date of the inspections. If the date of the inspection falls between any of the mating disruption periods for that orchard, TRUE must returned. Otherwise FALSE must be returned.

I've managed to create a custom function that evaluates the dates for a given orchard name. The operation is quite expensive and takes 12 seconds to complete on a dataset with 300 rows.

Maybe my formula is too complex?

I also don't know how to make this calculation for multiple orchards. Because there is no way of joining the two tables.
Any ideas?

