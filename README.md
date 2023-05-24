# Sprint Planning - Contract Net Protocol

Sprint planning estimates using Contract Net Protocol to define the group of developers for some tasks inside a project using Multi-Agent Systems.


## agents

1. Manager

- Have the list of tasks
- Call for the proposal of the developer team
- Get the median of the proposals
- Show the winner proposal

2. Developer

- Receive a task to send a proposal
- Send the proposal based on its beliefs

## namespaces

- use the task ID
- initialize the CNP sending the `task(ID, Difficulty)`


## results

```
# results

easy1 =>
easy2 =>
easy3 =>
easy4 =>
easy5 =>

2 jun
2 plen
1 sen

----	

medium1 =>
medium2 =>
medium3 =>
medium4 =>

1 jun
4 plen

----

hard1 =>
hard2 =>

1 plen
4 sen

----

impossible1 =>

1 plen
4 sen
```


## Resources

- [Jason stdlib](http://jason.sourceforge.net/api/jason/stdlib/package-summary.html)
