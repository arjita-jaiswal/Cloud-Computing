import boto3
ec2 = boto3.resource('ec2')
s=ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
print("All running instances :")
for instance in s:
    print (instance.id,instance.state)
print(" ")
print("Health status :")
for status in ec2.meta.client.describe_instance_status()['InstanceStatuses']:
    print(status)

s.stop()
print(" ")
print("All instances :")
for instance in ec2.instances.all():
    print (instance.id,instance.state)
