# Legacy AZ 104 Cram Notes

This is a in depth notepad im keeping while watching John Savill's Video AZ-104 SUPER Study Cram <https://www.youtube.com/watch?v=VOod_VNgdJk&t=9057s>

## Azure AD

### Identity and Azure AD

Azure AD acts as the identity provider for the cloud.

OIDC, SAML, WS-RED, OAuth2 all operate over HTTPS.

To communicate with these standards you are able to use REST API's like MS Graph.

Azure AD is not the same as Active directory on premises.

Communicates Kerberos, NTLM, LDAP.

### AAD Connect or Azure AD Connect Cloud Sync

This lets us replicate objects from Active directory on premises to Azure AD, It only goes from on prem up to Azure AD.

Tenants are instances of Azure AD, You get a default tenant and can have custom Tenants or Domains.

The default is a X.onmicrosoft.com domain.

Azure AD does not live in a subscription, subscriptions trust an Azure AD instance.

When you establish that trust you can use those identities to give access to those subscription resources.

You can have customization for your Azure AD tenant, like custom logos and background images.

### Users

The Directory Synced column identify identities that were brought from on premises active directory.

You can create identities that only exist in azure AD.

You can add guests, from other Tenants, microsoft accounts, and gmail accounts. The originating identity provider checks passwords and stuff, and you give permissions in your azure AD tenant. This could be subscriptions, sharepoint, or third party apps configured to trust your tenant.

The identity issuer column identifies the originating identity provider for an account or identity

You can download a csv template and upload it to bulk create users

You can use powershell to bulk create

### Groups

You want to assign groups permissions vs giving a single user permissions to a resource

If you have groups in active directory they could replicate up to azure AD

In azure AD there is the ability to create dynamic groups, based on user attributes vs assigned groups

If you allow Azure AD roles to be assigned to a group you can only have it set to assigned

### Devices

They can be known to azure AD

There are two methods to make it known to azure AD. Options are a Register and Join

Register - device becomes known to azure AD can be managed with Intune and stuff

Join - login AAD users

### Azure SKUs

Azure AD is free

Licenses can be added per user to grant additional features, like conditional access.

Free sku doesn't give full features to you, it gives you MFA

Azure AD Premium P1 and P2 are premium SKUs, it gives you conditional access and P2 gives you things like entitlement management, privileged identity management for just in time access

### Self Service Password Reset

Available for free to just Azure AD accounts

Self service password reset doesn't work for the free SKU of Azure AD connect, it doesn't copy the reset password down to the on premises server

You can set up self service password resets for users with multi factor authentications, you can determine how many methods to use, how may questions are required.

You need to be a Global Admin to do this

### Administrative Units

There are tons of default roles available to manage things in azure AD, they are really just sets of permissions. They exist at the tenant level and populate to everything.

Azure AD isn't hierarchial in nature, its really flat.

Administrative units let you sorta break that rule

They let you create a unit then add users and groups to it, and then add roles to the unit to give them permissions to do things.

Roles give people permission to do things.

If you add a group to a administrative unit, you cant manage people inside of the group, you can only manage the group itself.

If you want to manage users, you need to explicitly add them

You need to be a global admin to administrate Administrative Units

## Administration and Management

### Subscriptions

Each subscription trusts a particular azure AD tenant.

The users and groups in the tenant can be given permissions to resources in that subscriptions

Subscriptions can be given through a retailer, or reseller, there are even free options

### Cost Analysis and Budgets

Azure bills you based on consumption

If you want to learn what you are spending go to the Cost Management and Billing to get the scoop

You can get daily costs

You can create budgets, there are two types. Actual and Forecasted.

You can create actions to trigger when certain percentages of your budget are hit like emailing you, stopping things, or texting you.

Forecasting does an analysis of what you have spent and guesses what your budget may get to, you can also get notifications if your forecast reaches a certain percentage of your budget to manage cost.

Advisor recommendations are included to help you save money.

can be applied at a subscription, resource groups, and management groups

### Resource groups

You create them inside of subscriptions, and you can create multiple groups.

Inside of these groups you create resources.

You put things in resource groups that have a common lifecycle. They get created and will get destroyed together

Budgets can be applied at a resource group

### Management groups

At the tenant level you have a root management group

beneath that you create sub groups and eventually associate subscriptions to them

You can assign budgets at the management group level

### Tags

A key value pair

It is a way to easily find resources for billing or curiosity

It's a great way to add metadata to resources or resource groups

**TAGS DON'T GET INHERITED DOWN**

### Policy

You can use policies to provide self service to manage things with guardrails

You can assign a policy to get tags to be inherited down

You can set things like regions that can be used, timezones, etc.

Policy can be applied to Management groups, subscriptions, and resource groups

All of this flows through the azure resource manager API

It could track things, force and stop you, and remediate things

You can track compliance of policies

You assign the parameters for lots of policies like Allowed locations

#### Initiatives

Initiatives use multiple policies to achieve a certain idea like NIST security or New Zealand traffic

Azure security center has its own initiative to track the security of your subscriptions

You can make your own policies and initiatives

### Roles

This lets us give different permissions to do things

This is called Resource Based Access Control (RBAC)

Role - Identity - Scope

You assign a role to a certain identity to a certain scope. This is called Role Assignment.

They can be applied at a management group level, a subscription, and a resource group, even resources but its not advised

Default roles are Owners, Contributors, and Readers.

Owners can do anything.

Contributors can create anything and modify, but cant change permissions.

Reader, cant create anything, but can read it.

Permissions can be based on actions to interact with the control plane or can be based on DataActions to interact with the data plane

Custom roles can be built off of resource providers giving you functionally to configure

You can assign actions and notactions to edit what permissions a role has

### Control and Data Plane

Interactions with azure typically take place with the Azure Resource Manager, and it exists at the control plane to start and stop resources

Resources sitting below the control have different APIs and Capabilities and exist at the Data Plane

### Activity Log

In your subscription you are provided a log of everything going on at the control plane in that subscription

Resources have activity logs also! But they are only at the control plane

You could filter to Operation and role to get information who did something with roles like creating or deleting assignments

### Regions

Azure is a service that creates resources in regions typically, a huge network around the world that are filled with regions

Regions comprise of various datacenters

There are multiple clouds, a public cloud and restricted clouds by nationality like AzureChinaCloud or enclave like Azure USGovernment

In your subscription you can choose to use nearly any region

Inside of regions there are availability zones, each zone has independent power, cooling, and networking. This provides resiliency.

Zone Redundant means its distributed for you

Zonal means its in a specific Azure Zone (like az1 from az1 az2 and az3)

Some regions may not have the product you want, so you may need to shop around

When picking a region you want to put your resources close to your customers, and if you can, create resources at multiple regions to prevent natural disasters from taking down your service

### Paired Region

Some resources automatically asynchronously replicate across regions

Some regions are paired automatically, they are datacenters whose region servers are 100s of miles apart

Many services offer you the ability to pick if you want to replicate, some are native

## Networking

You typically only pay for data leaving azure but not ingress, data coming in. There are some exceptions

### Virtual Networks

Lives within two boundaries, a subscription and a region. It cannot span past that.

Subnets are used to chop up your virtual network

Your virtual network is always a IPv4 CIDR range, and optionally you can implement IPv6 CIDR range

Typically your addresses adhere by RFC 1918, 10/18, 172.16/12, 192.168/16

Your IP range needs to be unique, If there are conflicts there will be issues with routing

With each subnet you create you lose 5 IPs

These are .0, .255, .1, .2, .3
.0 for network addresses
.1 for gateway
.2 and .3 for DNS
.255 for Broadcast

When you create a resource you get a ip address assigned to it from DHCP, the typical first address would be .4, since it needs to skip the reserved. That is its private IP

The resource can by default get outbound connections to the internet and not be accessed by the public

For some services that need the same ip address each time it starts up, the resource will always use DHCP, but at the azure level you can create a reservation for a certain ip. In the resources ip configuration you can set the ip you are given to be assigned static like vs dynamic.

### Public IP

To let the public access a resource, it needs to be assigned a public ip

Typically you want to use a load balancer to let the public access a resource that sends traffic to each resource it manages.

A Public IP is always bound to a particular region

There are two types of Public IP, Standard and Basic

If its standard its always static, is zone redundant, and will be paired with the same sku load balancer

If its basic it can be dynamic or static

### VNET Peering

Lets one or more virtual networks talk, Either in the same region or global peering

Can also peer to a different azure tenant if you trust it

If you have the same ip address range you cant overlap ranges and cant establish a peer

The peer is bidirectional

To peer to a network you need the peer virtual network permission on the destination

You can let other VNETs that are peered to you use your virtual network gateway. You need to tell them to use remote gateways and allow gateway transit on destination network.

VNET Peerings aren't natively transitive

You can instruct traffic to route through a network virtual appliance and have it go to the other peer without peering the originating and destination VNET

### Network Security Groups

Rules that let you control traffic

Rules comprise of Priority, Name, Source, Destination, Port, Action (allow / deny)

Your source and destination could be IP addresses, Service Tags, Application Security Groups, or VNET

In a NSG the source or destination "Virtual Network" does not mean the VNET, it means the known ip space of the virtual network (peerings and on premises connections)

Internet means everything thats not the "Virtual Network"

Service Tags are massive numbers of ip addresses that azure knows as resource providers, like for Storage in South Central US

Generally we try to associate NSGs to subnets, You can do the nic level but it sucks

The rule is enforced at the switch level, so doubling rules doesn't double protection

You can check to see what rules are affecting your vm by selecting networking and pulling up the VNET or effective security rules, along with effective routes.

Operates at layer 4 (transport layer TCP/UDP)

### Azure Firewalls and routing

You deploy this into your virtual network, into its own subnet, a /26

Its a native highly available appliance

Rules

NAT / DNAT, Network (layer 4), Application (layer 7)

You can setup user defined routing to create a routing table that dictates your next hop has to be the azure firewall

You then associate that routing table to other subnets or resources

You can set up certificates on the firewall to encrypt and decrypt traffic

Typically you want to establish a firewall per region

### Azure DNS Services

DNS allows us to map names to ip addresses and azure DNS provides that capability

Public facing Azure DNS is focused on Host records (A/AAAA) and CNAME records

Private facing Azure DNS is more flexible, it can take manual additions, automatic registration, A, CNAME, SVC....

You pick the name for the zone public or private, then you can associate that zone with a virtual network

A VNET can register to one Azure DNS zone for registration

Each Private Azure DNS zone can link up to 100 VNETs, giving you consistent naming across VNETs

You can also have VNETs connect for just resolution, to resolve DNS names, You can associate 1000 private azure DNS zones to a VNET and a VNET to 1000 private azure DNS zones

When you create a vm, there is an ip address that always works for azure DNS (168.65.129.16) That ip address only works in azure

### Site to Site (S2S) VPN

We can take a VNET and connect it to some other network (other cloud providers, on prem, etc.) with this VPN

To use S2S VPN you need to have a VPN gateway, and a subnet that acts as the gateway subnet as a /27 (niche cases can use /29)

There are 2 types of VPNs

Policy based VPN - 1 Tunnel, encrypts the traffic and sends it through the tunnel (legacy, only works for basic tier)

Route based VPN - Directs the traffic to a particular tunnel and then encrypts it, as many tunnels as you need, does support point to site vpn, can coexist with express route gateway

This connection is established over the internet with IPSEC, speed and latency can vary

Gateway SKUs can scale the tunnels, P2S SSTP Connections, Speeds, etc.

The speed of your gateway is aggregate, so all the connections can move at max of X gig per second once added all together

VPNs have Azure side and on prem side devices

azure runs active passive typically, and can be configured to run active active to hit more on prem gateways, up to you.

You connect your on prem public ip to azure gateway public ip to set up the connection

### ExpressRoute

Azure has a massive backbone global network

You can pay for your network to meet with the massive backbone azure network at meet-me locations

This gives you private connectivity

Global reach is a feature that lets you talk to your own facilities over express route

There is two sessions connecting you to express route, active active

Price is based on speed and egress

Premium lets you connect globally, standard lets you connect within geopolitical boundaries

On top of express route, you connect through private peering, using an ExpressRoute gateway

Traffic coming into ExpressRoute comes in through the gateway

Traffic going out goes to microsoft's enterprise edge routers

Inbound traffic can use fast path to go directly to the target, you need the ultra gateway for it

Microsoft Peering lets us use a route filter to get the public ips of services advertised through BGP, allowing quick connection to public resources

Express route is not natively encrypted

If you really need it, you can use a vpn gateway over express route.

### Virtual WAN

Black box solution

It's a managed virtual network, with two tiers

A basic tier offering S2S VPN

A standard tier that offers S2S VPN, Express Route, Point to Site VPN (P2S)

The idea is you peer VNETs to the virtual wan, the standard tier lets you do communications between VNETs even if they aren't peered

You can connect virtual WANs together

### Service Endpoints

Controlling the flow to PaaS Services, even ones that don't exist in your virtual network

You create a subnet that is known to different types of services (like storage)

Service endpoints creates special routes that detect what you are trying to do and creates a more direct route. When a subnet needs to access a resource with a service endpoint it moves to it quicker.

### Private Endpoint

Uses an IP address in a particular subnet, and it represents an instance of a service, it takes down a public ip, and allows routing to the service through the private endpoint.

You can also use this for your own services!

### Azure Load balancer

A load balancer has a frontend IP address that clients can route to for an app or a service

Azure load balancer is a layer 4 load balancer, uses TCP and UDP, ports, etc...

Backend pools feed the load balancer with options on where to route to

Your load balancer uses rules to decide where to send traffic

this can use rules in 5,3,2 tuples

Tuples are how many elements of the layer 4 session need to stay the same to be routed to the same endpoint

The free sku can provide 300 backend resources that are in the same availability set or vm scale set. No SLA

The standard sku can provide up to 1000 in the same vnet, has availability zone support

### Azure App Gateway

You can have a layer 7 balancer, that understands things like https and web sockets.

Frontend IP thats always a public one, and optionally you can have a private

You create a listener thats tied to a frontend ip config

you can configure things like ssl offload, or certificates

You can set up listen rules, a basic one that takes all input and sends a certain rule

a multi site listener can sit at many locations and have one public ip, and depending on your filly qualified domain name it sends you a certain rule

rules can be basic or path

If the traffic is going to blob it goes to one backend, if shopping carts, go to another backend

### Global balancers

Typically load balancers are regional solutions, but there are some global options

Azure front door can do different kinds of layer 7 routing

Azure global load balancer can do different kinds of layer 4 load balancer by pointing to regional load balancers

Azure traffic manager is a dns load balancer

## Resources

### Storage

Structured, in a schema that can be loaded into a database

unstructured, could be loaded into datalakes

it all ties back to a storage account.

Its given a name, it needs to be lowercase and has to be globally unique.

You deploy it to a region, You should pick the place where you want to use your service, like in the same place your compute is

There are different services exposed in a storage account

Blob, Block Blobs(big stuff), Page Blob (made for random read write), append (writing to the end for logs)

Blob has support for data plane rbac

Files, Primarily SMB, now you can do NFS. Can tie into active directory

Queues, First in first out

Tables, no schema, but unstructured relational data

#### Performance

Standard or premium

Standard is General Purpose v2

Premium tells you to pick what kind of data is stored in it

Standard is hard disk drive based

Premium is more SSD based

#### Replication

Redundancy, You have the idea of a region that has multiple availability zones

LRS (3 copies of the data in a datacenter)

ZRS (3 copies distributed across the datacenters in the regions)

GRS (Three copies of your data in one facility, and 3 more in a paired region 100s of miles away)

GZRS (3 copies in 3 availability zones, the redundant region has 3 copies in paired regions facility)

RA-GZRS (always asyncronous and can be read from, read only)

### Importing Blob

When you want to get a large amount of data into a blob

theres uploading through the portal

Storage explorer

AZCopy

Data Box is an appliance microsoft ships to your data center, and you load data into it

### Tiers and Lifecycle

When you don't need low latency top performance, you can select access tiers on your data to decide how quickly you need to access something, from instant, to a few hours, to a week

Hot tier

Cool tier

Archive

Premium is completely different

You can set up rules to start a lifecycle management process that interacts with your files. Such as when it was last accessed or when uploaded

### Object replication and data protection

With object level replication you can create containers in other storage accounts and direct at a granular level where your containers replicate to, with rules for making decisions

soft delete helps you recover things

you can set up tons of data protection options to keep your data safe

Azure files have tiers also and get a hot and cool option that charges you for transactions

#### Azure files AD integration

You can integrate on prem active directory to let your active directory enable rbac when trying to access files

### Azure File Sync

You can get on prem files to your cloud endpoint with this

You can have one cloud endpoint and multiple on premises endpoints (up to 100)

It can keep ACLs

It can do tiering, tracking the storage on your local server and if you reach a rule it could offload files

### Access Keys, Shared Access Signatures, and RBAC

Access keys are all powerful and always appear in 2

Shared access signatured can be given out with time limits and allowed ips, but they are linked to access keys, so those need to be turned on so they can sign the SAS key

You can assign roles to blobs at the data plane to control permissions like read, write, delete, etc...

### Encryption

storage accounts are always encrypted

You can create different encryption keys for distant customers

### Managed disks

Managed disks cause the storage resource to become abstracted to provide capacity, latency, iops, t/p

STD hdd

STD SSD

Premium SSD

Ultra Disk

To use Premium SSDs and Ultra Disks you need to use S Variants A common thing in azure is the larger the disk, the higher the capacity the higher the iops and t/p

ultradisks can let you individually mess with capacity, iops, and t/p

You can increase the size of a disk but you cant shrink a disk

For STD SSD, Premium SSD, and Ultradisk, you can share the storage with multiple VMs

Disks have a performance set of characteristics, but resources that you connect them to also have a limit of performance

## Compute Services

Components of compute

Storage > Networking > Compute > Hypervisor > OS > Runtimes > Application > Data

In IaaS You only get a Vm provided by a hypervisor

in PaaS You only are expected to get your app deployed onto a vm thats configured completely for it

in SaaS You only are expected to generate data from the app your given

### Virtual Machines

It has Cpu's, memory, iops and t/p, network

When you process work you require a combination of cpu, memory, storage.

When your using this resource you are running it on a host

A Host has resources as well, to offer to vms

Your VM can use managed disks and the host has local disks that it uses as a vhd and offers a temp or scratch drive, its super low latency and high performance

Some hosts have gpus and nvme storage to give high performance components to your virtual machines

You are going to pay for things that are running, and you can use the pricing calculator to figure out your prices to plan expenses out.

### Extensions and backup

You can add tons of functions to vms like adding DSC, Chef, and even backups

You don't need to do the work to set it up, you simply need to enable these items, and for backups you just create policies and it makes it so with recovery vaults

### VM access and Bastion

Vms should not be connected to over private IPs

Azure Bastion offers you the ability to rdp into virtual machines in your virtual network

Its a resource you set up in the host, not just a vnet

### VM Resiliency

Fault domains are small units of vm hosts that could fail, if you have multiple fault domains, you increase the resiliency

Availability sets let you deploy to multiple fault domains

You can have between 5 and 20 update domains

Update domains can be a different blade of a rack or fault domain

Don't mix workloads in your availability set

### VM Scale sets

Its a template, config, vm size, min/max, autoscale

autoscale uses rules to add and remove devices based on cpu usage or memory

Horizontal scale is increasing the amount of vms you use to scale based on load

### Containers and ACI

Container hosts has a os and container runtime, and have a isolated sandbox to use with its own network cards and resources

Container registries has a file like a dockerfile that can create an image, based on the file

### AKS

Kubernetes takes alot of work to set up

AKS is a azure environment

mgmt - API server, ETCD DB, scheduler, controllers

node - pools that a kubelet that chat with the mgmt layers to make pods that run your workload or app

azure cni gives pods real ip addresses

kubenet lets network connections take place through the network

if you want persistent storage you can connect it to azure files std or premium or azure disk

autoscale is native to all this, cluster autoscale and pod autoscale

### App Services

HTTP/s Web, mobile, and api apps that use an app service plan

It could use a set of resources that gets chopped up as app services for the app

deployment slots allow you to split your instances between production and staging to test things out and quickly swap slots to deploy new features or roll back broken features

### Monitoring

Subscriptions get their own activity log

Individual resources have metrics and logs.

By default they go to azure monitor metrics

Diagnostic settings let you manage resources logs and capture them to be sent to a target

A target could be...

storage for long term retention

Event hub is a publish subscribe tool, good for an external SIEM

Log analytics workspace for a premium azure solution that can be interacted with by KQL for analysis

### Alerts and Actions

Alert rules keep an eye out and trigger action groups

### Network Watcher

They let you generate topology, check IP flow, nsg flow logs, all kinds of traffic analytics
