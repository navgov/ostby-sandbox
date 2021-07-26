# To order new subscriptions:
  ## Add a new structure to teams.yaml:
  ```
  - team: teamexample
    type: online
    environments:
      - name: dev
        monthlyLimit: 1000 
      - name: test
        monthlyLimit: 1500
      - name: prod
        monthlyLimit: 2000
    contacts:
      technical: daniel.brochs@utv.trygdeetaten.no
      budget: daniel.brochs@nav.no
   ```
## Explanation:
#### team : 
name of your team, small caps only, single string, no spaces.
#### type :  
Two archetypes available : onprem | online
##### online :  
accessible from internet - not connected to onprem network  
##### onprem  
internet behind onprem firewall, connected to onprem network through expressroute  
#### environments :  
##### Name:  
dev | test | prod  
Up to 3 separate environments can be provisioned. Specify as needed.  
##### monthlyLimit:  
Initial budget limit. Budget will be automaticly provisioned. This is audited by NAV cost controller, and you also supply a team spesific contact that will receive warnings regarding costs. Default budget issues warnings when 40 and 80 % of spesified budget is spent.  
#### contacts :
##### technical:  
valid UPN
Technical contact will be given Owner permissions on all subscriptions provisioned. Owner can further delegate permissions to anyone they choose within the provisioned subscription scopes.
Technical contact will also be given ownership to a serviceprincipal that can be used for automation within the scopes.

##### budget
valid email address
email address of person within team that will be responsible for costs. Provided email will be notified when budget reaches 40 and 80 % of specified monthly limit.

## Provisioning workflow
1. PR with new yaml content is created.
2. Yaml is subject to automated integration check as pre-req to merge
3. On merge:  
Subscriptions are created  
Serviceprincipal for automation is created  
Permissions for are set  
Standard tags are set  
Budget is set as deploy-if-not-exists policy. Will be available 24 hours after subscription creation.  
Subscription is moved to correct management group and will inherit policies from parent scope according to it's type.
