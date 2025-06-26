"""
Placeholder Lambda function for initial deployment.

This function will be replaced by CodePipeline when you push code to your
configured GitHub repository. This is a minimal working function that
prevents deployment errors.

To deploy your actual Lambda code:
1. Set up your GitHub repository with producer/ and consumer/ directories
2. Activate the CodeStar connection in AWS Console
3. Push code to trigger the CodePipeline deployment
"""

import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    """
    Placeholder producer function.
    
    This will be replaced by your actual producer code via CodePipeline.
    """
    logger.info("Placeholder producer function called")
    logger.info(f"Event: {json.dumps(event)}")
    
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': 'Placeholder producer function - deploy your code via CodePipeline',
            'event_received': event
        })
    }
