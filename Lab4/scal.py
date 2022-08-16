import boto3
import time

ec2 = boto3.resource('ec2')
client=boto3.client('autoscaling')

f = open("script.sh", "r").read()

launch_name='go'
grp_name='hit_it'


data_script = """#!/bin/bash
sudo yum update -y
sudo pip install --upgrade pip -y
touch test.py
echo "import boto" > download_html.py

echo "s3=boto.connect_s3(aws_access_key_id='AKIAUMP7OSRUKSZ2EA5Y',aws_secret_access_key='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', host='s3.ap-south-1.amazonaws.com')" >> download_html.py
echo "bucket=s3.get_bucket('arjitajaiswal')" >> download_html.py
echo "key1=bucket.get_key('arjita.jpg')" >> download_html.py
echo "key2=bucket.get_key('i.html')" >> download_html.py

echo "key1.get_contents_to_filename('arjita.jpg')" >> download_html.py
echo "key2.get_contents_to_filename('i.html')" >> download_html.py
sudo python download_html.py
sudo yum install -y httpd24 php56 php56-mysqlnd
sudo service httpd start
sudo chkconfig httpd on
sudo mkdir /var/www/
sudo mkdir /var/www/html/
sudo mkdir /var/www/html/
sudo cp i.html /var/www/html/i.html
sudo mv /var/www/html/i.html /var/www/html/index.html
sudo cp arjita.jpg /var/www/html/arjita.jpg"""

response=client.create_launch_configuration(LaunchConfigurationName=launch_name,
	UserData=data_script,
	ImageId='ami-0b99c7725b9484f9e',
	InstanceType="t2.micro",
	KeyName='arjita', 
	SecurityGroups=['launch-wizard-1'])


response=client.create_auto_scaling_group(AutoScalingGroupName=grp_name,
	LaunchConfigurationName=launch_name,
	AvailabilityZones=['ap-south-1a','ap-south-1b'],
	HealthCheckGracePeriod=120,
	HealthCheckType='ELB',
	MaxSize=3,
	MinSize=1)

#Create Cloudwatch Client

cloudwatch=boto3.client('cloudwatch')

#Create alarm

cloudwatch.put_metric_alarm(AlarmName='Web_Server_CPU_Utilization',
	ComparisonOperator='GreaterThanThreshold',
	EvaluationPeriods=1,MetricName='CPUUtilization',
	Namespace='AWS/EC2',
	Period=60,
	Statistic='Average',
	Threshold=70.0,
	ActionsEnabled=False,
	AlarmDescription='Alarm when server exceeds 70% CPU',
	Unit='Seconds')

response=client.put_scaling_policy(AdjustmentType='ChangeInCapacity',
	AutoScalingGroupName=grp_name,
	PolicyName='ScaleUp',
	ScalingAdjustment=-1)

cloudwatch.put_metric_alarm(AlarmName='Web_Server_CPU_Utilization',
	ComparisonOperator='LessThanThreshold',
	EvaluationPeriods=1,MetricName='CPUUtilization',
	Namespace='AWS/EC2',
	Period=60,
	Statistic='Average',
	Threshold=70.0,
	ActionsEnabled=False,
	AlarmDescription='Alarm when server receeds 70% CPU',
	Unit='Seconds')

response1=client.put_scaling_policy(AdjustmentType='ChangeInCapacity',
	AutoScalingGroupName=grp_name,
	PolicyName='ScaleDown',
	ScalingAdjustment=-1)

print("Finished")